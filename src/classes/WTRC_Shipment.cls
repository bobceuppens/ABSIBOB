/**
 * Creation Date: 	20110118
 * Description: 	WTRC_Shipment
 * 
 * Author: 	ABSI - Bob Ceuppens
 */	
 
public with sharing class WTRC_Shipment {

	private WTRC_Shipment__c myShipment {get;set;}
	
	public WTRC_Shipment(WTRC_Shipment__c myShipment) {
        this.myShipment = myShipment;
    }
    
	public WTRC_Shipment() {
    }
        
	public void processShipment(List<WTRC_Shipment__c> shipmentsToProcess){
		
		List<Id> accountsFromShipment = new List<Id>();
		
		for(WTRC_Shipment__c myShipment : shipmentsToProcess){
			accountsFromShipment.add(myShipment.Client__c);
		}
		
		Map<Id,Account> accountsForReference = new Map<Id,Account>([select Id,ShippingCity,ShippingPostalCode,ShippingStreet,Email__c,Phone,ShippingCountry from Account where Id =:accountsFromShipment]);
		
		User currentUser = [select Id,WTRC_Username__c,WTRC_Master__c from User where Id =: System.Userinfo.getUserId()];
		
		for(WTRC_Shipment__c myShipment : shipmentsToProcess){
			if (true) {
				System.debug('ABSILOG *** myShipment.Id ' + myShipment.Id + ' myShipment.Client__r.ShippingCity ' + myShipment.Client__r.ShippingCity + ' ################') ;
				myShipment.Client_City__c = accountsForReference.get(myShipment.Client__c).ShippingCity;
				myShipment.Client_Zip__c = accountsForReference.get(myShipment.Client__c).ShippingPostalCode;
				myShipment.Client_Street__c = accountsForReference.get(myShipment.Client__c).ShippingStreet;
				myShipment.Client_Email__c = accountsForReference.get(myShipment.Client__c).Email__c;
				myShipment.Client_Phone__c = accountsForReference.get(myShipment.Client__c).Phone;
				myShipment.Client_Country__c = accountsForReference.get(myShipment.Client__c).ShippingCountry;
			}
			myShipment.Username__c = currentUser.WTRC_Username__c;
			myShipment.Master__c = currentUser.WTRC_Master__c;
			myShipment.Service__c = 'SHIPMENT';
		}
	}
	
	public void prepareShipmentForSubmit(){
		System.debug('################# ABSILOG - prepareShipmentForSubmit() ' + '##########');
    	Set <String> fieldsToExclude = new Set<String>();
    	fieldsToExclude.add('wtrace_xml__c');
		String myXML = WTRC_XMLBuilder.getWTRCXML(myShipment,fieldsToExclude);
		myShipment.WTRACE_XML__c = myXML;
		update myShipment;
	}
	
   public Id ship(){
   		System.debug('################# ABSILOG - ship() ' + '##########');
        WTRACE_LabelPrinting.WS_LabelPrintingPort myWS_stub = new WTRACE_LabelPrinting.WS_LabelPrintingPort();
        myWS_stub.timeout_x = 30000;
        try {
        	System.debug('################# ABSILOG - myShipment.Id ' + myShipment.Id + ' myShipment.WTRACE_XML__c ' + myShipment.WTRACE_XML__c + '##########');
			String[] myResponse;
			myResponse = myWS_stub.getLabelPDF(myShipment.WTRACE_XML__c,'rutenber');
            Attachment a = new Attachment();
            a.ParentId = myShipment.Id;
            a.Name = myResponse[0];
            a.Body = EncodingUtil.base64Decode(myResponse[1]);
            insert a;
            
            if (myResponse == null) {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Er zijn geen gegevens beschikbaar voor deze klant');
                ApexPages.addMessage(myMsg);
                return null;
            }
            System.debug('################# ABSILOG - myResponse ' + myResponse + '##########');
            return a.Id;
        }
        catch (CalloutException ex) {
        	 System.debug('################# ABSILOG - CalloutException ' + ex + '##########');
            ApexPages.Message myMsg;
            if (ex.getMessage().contains('IO Exception')) { 
                myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Er is een probleem opgetreden met het ophalen van de gegevens');
                ApexPages.addMessage(myMsg);
            }
            if (ex.getMessage().contains('parse')) {
                myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Er is een probleem opgetreden met het ophalen van de gegevens');
                ApexPages.addMessage(myMsg);
            }
            return null;
        }catch (Exception ex) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Er is een ongekend probleem opgetreden. Gelieve de beheerder te contacteren');
            ApexPages.addMessage(myMsg);
            System.debug('################# ABSILOG - WTRACE_controllerLabelPrinter ' + ex.getMessage() + '##########');
            return null;
        }
    }

}