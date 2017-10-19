@isTest(SeeAllData=true)
public with sharing class WTRC_Test {
	
    public static TestMethod void XMLTest() {

    	WTRC_Shipment__c myShipment = new WTRC_Shipment__c();
/*    	
    	insert myShipment;
*/
    	// For development hardcoded to SHIP-000002
    	List<WTRC_Shipment__c> myShipments = [select Id from WTRC_Shipment__c Where Id =: 'a05C000000AYVJF'];
    	
/*    	
    	myShipments.add(myShipment);
    	
    	String mySOQL = Util.getSOQL('WTRC_Shipment__c',new List<Id>{myShipment.Id});
		try {
		        myShipments = database.query(mySOQL);
		} catch (QueryException e){
		        //perform exception handling
		}
		
		List<sObject> mysObjects = Util.getSobjects('WTRC_Shipment__c',new List<Id>{myShipment.Id});
		myShipments = (List<WTRC_Shipment__c>) mysObjects;
*/		

		myShipment = myShipments.get(0);

    	Set <String> fieldsToExclude = new Set<String>();
    	fieldsToExclude.add('wtrace_xml__c');
/*    	
    	String myXML = WTRC_XMLBuilder.getXML(myShipments,fieldsToExclude);
    	System.debug('################# ABSILOG : myXML ' + myXML + ' ##########');
*/    	
    	PageReference pageRef = new PageReference('/' + myShipment.id);
    	pageRef.getParameters().put('id',myShipment.id);
    	Test.setCurrentPage(pageRef);
    	ApexPages.StandardController sct = new ApexPages.StandardController(myShipment); //set up the standardcontroller
	 	WTRACE_controllerLabelPrinter myController = new WTRACE_controllerLabelPrinter(sct);
		myController.submitShipment();
    }
}