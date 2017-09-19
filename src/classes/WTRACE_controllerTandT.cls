public with sharing class WTRACE_controllerTandT {
	
	// Account called by the vf page ! 
    private Shipment__c myPD;
    public Shipment__c getPD(){return this.myPD;}
    public void setAcc(Shipment__c myPDIn){this.myPD = myPDIn; }
    
    public WTRACE_TandT_DTO Wtrace_DTO {get;set;}
	public String myTandTXML {get;set;}
	
	public boolean renderTandTBlock {get;set;}
		
	public WTRACE_controllerTandT(ApexPages.StandardController stdController) {
		renderTandTBlock = false;
		myPD = (Shipment__c) stdController.getRecord();
		System.debug('################# myPD : ' + myPD + '##########""');
		init();
	}

	public void init() {
		myPD=[Select a.ID__c,a.master__c From Shipment__c a Where Id=:myPD.Id];
	}
	
	
	public void getWtraceTandT(){

		WTRACE_TandT.WS_TandTPort myWS_stub = new WTRACE_TandT.WS_TandTPort();
		myWS_stub.timeout_x = 30000;
		try {
			String myResponse = myWS_stub.getTrackTraceXml(myPD.ID__c,myPD.master__c,'');
			myTandTXML = myResponse;
			Wtrace_DTO = new WTRACE_TandT_DTO();
			Wtrace_DTO.bindData(myResponse);
			if (myResponse == null) {
				ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Er zijn geen gegevens beschikbaar voor deze klant');
				ApexPages.addMessage(myMsg);
			}
			renderTandTBlock = true;
			System.debug('################# ABSILOG : myResponse ' + myResponse + '##########');
		}
		catch (CalloutException ex) {
			ApexPages.Message myMsg;
			if (ex.getMessage().contains('IO Exception')) { 
				myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Er is een probleem opgetreden met het ophalen van de gegevens');
				ApexPages.addMessage(myMsg);
			}
			if (ex.getMessage().contains('parse')) {
				myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Er is een probleem opgetreden met het ophalen van de gegevens');
				ApexPages.addMessage(myMsg);
			}
		}catch (Exception ex) {
			ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Er is een ongekend probleem opgetreden. Gelieve de beheerder te contacteren');
            ApexPages.addMessage(myMsg);
			System.debug('################# ABSILOG : getWSNavisionAmountsDue ' + ex.getMessage() + '##########');
		}
	}

}