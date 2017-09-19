global class WTRCShipmentFactory extends GenericFactory{
    public override Schema.SObjectType getSObjectType(){
        return WTRC_Shipment__c.SObjectType;
    }
    public WTRC_Shipment__c makeWTRCShipment(Map<SObjectField, Object> valuesByField){
        return (WTRC_Shipment__c) this.makeRecord(valuesByField);
    }
}