trigger WTRCShipmentInsertTrigger on WTRC_Shipment__c (before insert) {
	
	List<WTRC_Shipment__c> shipmentsToProcess = new List<WTRC_Shipment__c>();

	for(WTRC_Shipment__c myShipment : System.Trigger.new){
			shipmentsToProcess.add(myShipment);
	}
	
	WTRC_Shipment shipmentProcessor = new WTRC_Shipment();
	shipmentProcessor.processShipment(shipmentsToProcess);
}