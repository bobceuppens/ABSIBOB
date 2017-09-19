/**
 * Creation Date :  20090227
 * Description : 	General tester class
 * Author : 		ABSI - BC
 */

@isTest
private class generalTester {

    static testMethod void myGeneralTester() {
		
		System.debug(' ################## ' + 'BEGIN myGeneralTester' + ' ################');
		
		generalTester myTest = new generalTester();
		
		// myTest.testSOQL();
		
		myTest.loopTest();
		
		System.debug(' ################## ' + 'END myGeneralTester' + ' ################');
		
    }
    private void loopTest(){
    	List<String> myList1 = new List<String>{'Jan','Bob','Miguel','Sven','Sander'};
    	List<String> myList1_new = myList1.clone();
    	List<String> myList2 = new List<String>{'Tom','Rik','Bob','John','Sander'};
    	List<String> diff = new List<String>();
    	List<List<String>> my_list_2 = new List<List<String>>();
    	boolean hasMatch;
    	for (String val1:myList1) {
			System.debug(' ################## ' + 'myList1.get' + val1 + ' ################');
			hasMatch=false;
			for (String val2:myList2) {
				if (val1 == val2) {
					System.debug(' ################## ' + 'MATCH' + val2 + ' ################');
					hasMatch=true;
					break;
				}
			}
			if (!hasMatch)
				diff.add(val1);
		}
		for (Integer i=0;i< diff.size();i++) {
			System.debug(' ################## ' + 'New: ' + diff.get(i) + ' ################');
		}
    }
    /*
    private void testSOQL(){
    	Map<String, String> testMap = new Map<String, String>();
    	List<String> referringContacts = new List<String>();
    	List<String> implContacts = new List<String>();
    	Implant__c[] impls = [Select Id,Implant_Referring_Contact__c,Implant_Implanting_Contact__c From Implant__c];
    	for (Implant__c impl:impls) {
    		referringContacts.add(impl.Implant_Referring_Contact__c);
    		implContacts.add(impl.Implant_Implanting_Contact__c);
    	}
    	String SOQL = 'Select Affiliation_To_Contact__c, Affiliation_From_Contact__c From Affiliation__c where RecordTypeId = \'' + FinalConstants.recordTypeIdC2C + '\'';
    	SOQL = SOQL + 'and(';
    	SOQL = SOQL + 'Affiliation_From_Contact__c = \'' + referringContacts.get(0) + '\' and Affiliation_To_Contact__c = \'' + implContacts.get(0) + '\'';
    	SOQL = SOQL + ')';
    	System.debug(' ################## ' + 'SOQL= ' + SOQL + ' ################');
    	Affiliation__c[] affs2 = Database.query(SOQL);
    	Affiliation__c[] affs = [Select a.Affiliation_To_Contact__c, a.Affiliation_From_Contact__c From Affiliation__c a 
    								where RecordTypeId =: FinalConstants.recordTypeIdC2C
    								and (
    									(Affiliation_From_Contact__c =: referringContacts.get(0) and Affiliation_To_Contact__c =: implContacts.get(0))
    								or 	(Affiliation_From_Contact__c =: referringContacts.get(1) and Affiliation_To_Contact__c =: implContacts.get(1))
    								or 	(Affiliation_From_Contact__c =: referringContacts.get(2) and Affiliation_To_Contact__c =: implContacts.get(2))
    									)];
    	System.debug(' ################## ' + 'affs.size()= ' + affs.size() + ' ################');	
    }
    */
}