public class DynamicApexTest {

    public static void descObj() {
        
        Map<String, Schema.SObjectType> globalSchemaDesc = Schema.getGlobalDescribe();
        Set<String> objNames = globalSchemaDesc.keySet();
        System.debug('How many objects do we see? ' + globalSchemaDesc.size());
        for (String objName : objNames) {
            //System.debug('Object Name=' + objName);
        }
        
        Schema.SObjectField field = Account.AccountNumber;
		// Get the describe result for the Name field on the Account object
		Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.Contact.fields.getMap();
		Schema.SObjectField field1 = Contact.lastname;
		System.debug('Object Name1= ' + field1.getDescribe().getName());
		String contactMapper = 'nationality__c';
		Schema.SObjectField field2 = fieldMap.get(contactMapper);
		//Boolean contains = fieldMap.containsKey(contactMapper);
		//System.debug('Contains: ' + contains);
		Set <String> fieldSet = new Set<String>();
		fieldSet = fieldMap.keySet();
		if ( fieldSet.size() > 0 ) {
  			for (String fieldKeys : fieldSet) {
    			System.debug('Object Key:' + fieldKeys);
 			}
		}
		System.debug('Object Name2= ' + field2.getDescribe().getName());
		String contactId = '0038000000XLIkH';
		Contact tempContact = [select Id,lastname from Contact where Id =:contactId limit 1];
		//System.debug('Contact Name= ' + tempContact.Name);
		tempContact.put(field2,'YESSSS');
		tempContact.put(field1,'newName');
		update tempContact;
		//tempAccount.put(selectedField.getLabel(),quantityToAdd + existingQuantity);
    }
    
    static testmethod void testQueryLimitNewDonation(){
        descObj();
    }

}