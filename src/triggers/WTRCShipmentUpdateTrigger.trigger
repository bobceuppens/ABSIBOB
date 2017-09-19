trigger WTRCShipmentUpdateTrigger on WTRC_Shipment__c (before update) {
	
	List<WTRC_Shipment__c> shipmentsToProcess = new List<WTRC_Shipment__c>();
		
	for(WTRC_Shipment__c myShipment : System.Trigger.new){
		if (Trigger.oldMap.get(myShipment.Id).Client__c != myShipment.Client__c) {
			shipmentsToProcess.add(myShipment);
		}
		WTRC_Shipment shipmentProcessor = new WTRC_Shipment();
		shipmentProcessor.processShipment(shipmentsToProcess);
	}
}