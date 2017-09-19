trigger Opportunity_AfterUpdate on Opportunity (after update) {
	
	List<Opportunity> oppsNew = Trigger.new;
	List<Opportunity> oppsToBeDeleted = new List<Opportunity>();
	
    for(Opportunity opp : oppsNew) {
    	System.debug('################# ' + 'Opportunity_AfterUpdate : opp.ConnectionReceivedId ' +  opp.ConnectionReceivedId + ' ################') ;
	   	If (opp.ConnectionReceivedId == null) {
			If (Trigger.oldMap.get(opp.Id).ConnectionReceivedId != null) {
				oppsToBeDeleted.add(opp);
			} 	
	   	}
    }
    delete oppsToBeDeleted;
}