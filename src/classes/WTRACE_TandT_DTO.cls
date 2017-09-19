public with sharing class WTRACE_TandT_DTO {
		
		public WTRACE_TandTElement myTandTElement {get;set;}
		
		public WTRACE_TandT_DTO() {
		}
		
		public boolean bindData(String myTandTElementIn) {
			myTandTElement = new WTRACE_TandTElement();
			WTRACE_XMLParser myParser = new WTRACE_XMLParser();
			myParser.parseXML(myTandTElementIn, myTandTElement);
			return true;
		}

}