global class BatchTester_SCHEDULE_START {
	global void BatchTester_SCHEDULE_START(){}
 
	public static void start(){
		//Schedule the required batch jobs
 		System.schedule('BatchTester', '0 30 1-23 * * ?', new BatchTester_SCHEDULE());
 	}
}