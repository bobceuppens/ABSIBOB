/**
 * Creation Date:   20110118
 * Last Updated:    20121003
 * Description:     WTRACE_controllerLabelPrinter - Class handles Label Printing for Worktrace
 * 
 * Author:  ABSI - Bob Ceuppens
 */ 
 
public with sharing class WTRACE_controllerLabelPrinter {

    // Constructor - this only really matters if the autoRun function doesn't work right
    private WTRC_Shipment__c myShipment;
    
    public WTRACE_controllerLabelPrinter(ApexPages.StandardController stdController) {
        this.myShipment = (WTRC_Shipment__c)stdController.getRecord();
        System.debug('################# ABSILOG - myShipment.Id ' + myShipment.Id + ' ##########');
        
        System.debug('################# ABSILOG - EMAIL TEST START ##########');
        String[] toAddresses;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        toAddresses = new String[] {'bob@absi.be'};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Test email limits');
        mail.setPlainTextBody('Test email limits');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        System.debug('################# ABSILOG - EMAIL TEST END ##########');        
    }
 
    // Code we will invoke on page load.
    public PageReference submitShipment() {
        
        System.debug('################# ABSILOG - submitShipment ' + '##########');
        
        String theId = ApexPages.currentPage().getParameters().get('id');
 
        if (theId == null) {
            // Display the Visualforce page's content if no Id is passed over
            return null;
        }
        
        WTRC_Shipment__c myShipmentTest1 = [SELECT Content_Type__c FROM WTRC_Shipment__c WHERE Id=:theId];
        System.debug('################# ABSILOG - Content_Type__c ' + myShipmentTest1.Content_Type__c + '##########' );
        
        WTRC_Shipment__c myShipmentTest2 = [SELECT toLabel(Content_Type__c) FROM WTRC_Shipment__c WHERE Id=:theId];
        System.debug('################# ABSILOG - toLabel(Content_Type__c) ' + myShipmentTest2.Content_Type__c + '##########' );
        
        List<WTRC_Shipment__c> myShipments;
    
        List<sObject> mysObjects = Util.getSobjects('WTRC_Shipment__c',new List<Id>{myShipment.Id});

        System.debug('################# ABSILOG - mysObjects ' + mysObjects +'##########');

        sObject sObj = Schema.getGlobalDescribe().get('WTRC_Shipment__c').newSObject();
        sObj = mysObjects.get(0);

        WTRC_Shipment__c myShipment = (WTRC_Shipment__c) sObj;
        
        String shipmentLabelId;  
        WTRC_Shipment myWTRCShipment = new WTRC_Shipment(myShipment);
        myWTRCShipment.prepareShipmentForSubmit();
        shipmentLabelId = myWTRCShipment.ship();

        // Redirect the user back to the original page
        PageReference pageRef = new PageReference('/servlet/servlet.FileDownload?file=' + shipmentLabelId);
        pageRef.setRedirect(true);
        return pageRef;
    }

}