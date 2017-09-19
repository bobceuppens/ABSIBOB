global class BatchTester_SCHEDULE implements Schedulable{

	global void execute(SchedulableContext ctx){
		String query = 'SELECT Id, Name FROM User LIMIT 10';
		BatchTester batch = new BatchTester(query,'','','');
		Database.executeBatch(batch,1);
	}

}