public with sharing class WTRACE_TandTElement {

	public String traceType  {get;set;}
	public String senderId {get;set;}
	public String recipientId {get;set;}
	public String intRef {get;set;}
	public String item {get;set;}
	
	public List<WTRACE_TandT_Event> myTandTEvents {get;set;}
	
	public class WTRACE_TandT_Event {
		public String eventCode {get;set;}
		public String product {get;set;}
		public String item {get;set;}
		public String location {get;set;}
		public String handler {get;set;}
		public String actualDate {get;set;}
		public String businessDate {get;set;}
		public String master {get;set;}
		public String plannedFlag {get;set;}		
	}
	
	public class WTRACE_TandT_Address {
		public String id {get;set;}
		public String master {get;set;}
		public String company {get;set;}
	}
		
	public WTRACE_TandTElement() {
		myTandTEvents = new List<WTRACE_TandT_Event>();
	}
}