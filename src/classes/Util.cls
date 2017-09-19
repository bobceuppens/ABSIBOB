public with sharing class Util {
	
	/*
	* @description: A code snippet that mimics the popular Select * SQL syntax in force.com's Apex language.
	*/
	
	public static String getSOQL(String objectName,List<Id> listIDs) {
		
		// Initialize setup variables
		// String objectName = 'Contact';  // modify as needed
		String query = 'SELECT';
		Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
		
		// Grab the fields from the describe method and append them to the queryString one by one.
		for(String s : objectFields.keySet()) {
		   query += ' ' + s + ',';
		}
		
		// Manually add related object's fields that are needed.
		// query += 'Account.Name,'; // modify as needed
		
		// Strip off the last comma if it exists.
		if (query.subString(query.Length()-1,query.Length()) == ','){
		    query = query.subString(0,query.Length()-1);
		}
		
		// Add FROM statement
		query += ' FROM ' + objectName;
		
		// Add on a WHERE/ORDER/LIMIT statement as needed
		if (listIDs != null && listIDs.size() > 0) {
			System.debug('################# ABSILOG - List<Id> ids ' + listIDs + ' ##########');
			query += ' WHERE Id IN :listIDs';
		}
		
		/*
		try {
		        List<sObject> mysObjects = database.query(query);
		} catch (QueryException e){
		        //perform exception handling
		}
		*/
		
		System.debug('################# ABSILOG - query ' + query + ' ##########');
		
		return query;
	}
	
	public static List<sObject> getSobjects(String objectName,List<Id> listIDs) {
		
		List<sObject> mySobjects = new List<sObject>();
		
    	String mySOQL = Util.getSOQL(objectName,listIDs);
		try {
		        mySobjects = database.query(mySOQL);
		} catch (QueryException e){
		        //perform exception handling
		}

		return mySobjects;
	}	
	
}