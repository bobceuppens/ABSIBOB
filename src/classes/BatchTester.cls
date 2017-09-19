global class BatchTester implements Database.Batchable<sObject> {
	global final String Query;
	global final String Entity;
	global final String Field;
	global final String Value;

	global BatchTester(String q, String e, String f, String v){
		Query=q;
		Entity=e;
		Field=f;
		Value=v;
	}

	global Database.QueryLocator start(Database.BatchableContext BC){
    	return Database.getQueryLocator(query);
	}
	
	global void execute(Database.BatchableContext BC,LIST<SObject> myObjects) { 
		System.debug('ABSILOG *** TEST');
		System.debug('ABSILOG *** getOrganizationId ' +  System.Userinfo.getOrganizationId());
		System.debug('ABSILOG *** getUserId ' +  System.Userinfo.getUserId());
		System.debug('ABSILOG *** getSessionId ' +  System.Userinfo.getSessionId());
	}
	
	
	global void finish(Database.BatchableContext BC){
	}
}