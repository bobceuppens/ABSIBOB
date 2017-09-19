public with sharing class WS_Navision_DTO {
	
		// Generic
	  	public Datetime lastUpdatedDateTime {get;set;}
	  	
	  	// AmountsDue
        public WS_Navision_AmountsDue.ResponseOUT_element amountsDue {get;set;}
        public WS_Navision_Prices.ResponseOUT_element prices {get;set;}
		
		public void bindData(WS_Navision_AmountsDue.ResponseOUT_element elementIn) {
			amountsDue = elementIn;
			lastUpdatedDateTime = System.now();
		}
		
		public void bindData(WS_Navision_Prices.ResponseOUT_element elementIn) {
			prices = elementIn;
			lastUpdatedDateTime = System.now();
		} 		
}