public with sharing class WTRC_TransferOppToShipmentController {
	    
	    public String returnUrl{get;set;}
	    public Opportunity myOpp;
	    public Id shipmentId;
	    public WTRC_Shipment__c myShipment;
		public List<OpportunityLineItem> myOppLines;

	    public WTRC_TransferOppToShipmentController(ApexPages.StandardController controller){
	        this.myOpp = (Opportunity)controller.getRecord();
	    }

	    
	    public PageReference transferToShipment() {
	        String theId = ApexPages.currentPage().getParameters().get('id');
	        
	        returnUrl = '/' + theId;
	        //  returnpage > set to current page in case something went wrong
	        PageReference pageRef = new PageReference(returnUrl);
	        
	        if (theId == null) {
	            return null;
	        }
	        
	        Boolean errorDuringProcessing = false;
	        
	        Savepoint sp = Database.setSavepoint();
	        
	        shipmentId = createShipment();
	        
			if(shipmentId!=null){
                	//	refetch the created sales order and the country of the sold to
                	 myShipment = [Select Id, OwnerId from WTRC_Shipment__c where Id=:shipmentId];
                	 createShipmentLines();
			}
	        
            if(errorDuringProcessing == true){
            	Database.rollback(sp);
            }
			
			theId = myShipment.Id;
	        pageRef = new PageReference('/' + theId);
			pageRef.setRedirect(true);
			return pageRef;
			//return null;
				        
	    }
	    
		private Id createShipment(){
	        
	        WTRC_Shipment__c myShipment = new WTRC_Shipment__c();
	        
	        myOpp = [Select Id, Name,StageName,AccountId from Opportunity where Id=:myOpp.Id];
	        
	        myShipment.Opportunity__c = myOpp.Id;
	        
	        //  map the standard quote fields
	        myShipment.Client__c = myOpp.AccountId;
	        myShipment.Name = 'SHIPMENT_' + myOpp.Name;
			myShipment.Opportunity__c = myOpp.Id;
	        
	        /*
	        if(myOpp.CurrencyIsoCode!=null){
	        	myShipment.CurrencyIsoCode = myOpp.CurrencyIsoCode;
	        }
	        */
			try {
				insert myShipment;
	        	return myShipment.Id;
	        }
			catch(System.DmlException dEx) {
				for (Integer i = 0; i < dEx.getNumDml(); i++) {
					ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, dEx.getDmlMessage(i)));
			        System.debug(dEx.getDmlMessage(i)); 
			    }
					    
				return null;
			}
		}


    private Boolean createShipmentLines(){
    	Boolean linesCreated = false;
    	
        Integer counter = 1;
        
        if(myOppLines!=null){
            List<WTRC_Shipment_Line__c> shipLines = new List<WTRC_Shipment_Line__c>();

            for(OpportunityLineItem oppLine : myOppLines){
                WTRC_Shipment_Line__c shipLine = new WTRC_Shipment_Line__c();
                
                //  attach the sales order line to the correct sales order
                shipLine.Shipment__c = myShipment.Id;
                shipLines.add(shipLine);
                counter++;
            }
            
            try{
            	insert shipLines;
            	linesCreated = true;
            }
            catch(DMLException dEx){
            	for (Integer i = 0; i < dEx.getNumDml(); i++) {
			        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, dEx.getDmlMessage(i)));
			        System.debug(dEx.getDmlMessage(i)); 
			    }
			}
        }
		return linesCreated;
    }       


    private void loadOpportunityData(){

        //  get the linked quote lines
        myOppLines = [select Id, Description, PricebookEntry.Product2Id, PricebookEntry.Name, Quantity, UnitPrice, Discount
						from OpportunityLineItem where OpportunityId=:myOpp.Id];
        
        //	extract the product ID's from the quotelines        
        List<Id> productIds = new List<Id>();
        for(OpportunityLineItem myOppLine : myOppLines){
        	productIds.add(myOppLine.PricebookEntry.Product2Id);
        }

    }
		
}