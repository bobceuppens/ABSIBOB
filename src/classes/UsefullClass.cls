public with sharing class UsefullClass {

	 	public void UsefullMethod() {
		 	// get today's month & year
			Datetime todayDateTime = Datetime.now();
			System.debug('################## ' + 'Current_DateTime= ' + todayDateTime + '################');
			todayDateTime = todayDateTime.addMonths(-1);		
			System.debug('################## ' + 'Previous_DateTime= ' + todayDateTime + '################');
			String previousMonth = String.valueOf(todayDateTime.month());
			String previousYear = String.valueOf(todayDateTime.year());
			
			if (todayDateTime.month() < 10) {
				previousMonth = '0' + previousMonth;
			}
		}

}