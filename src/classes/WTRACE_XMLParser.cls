public with sharing class WTRACE_XMLParser {

	public void parseXML(String rawXML,WTRACE_TandTElement myElement) {
	    XmlStreamReader reader = new XmlStreamReader('');
	    try {
	        reader = new XmlStreamReader(rawXML);
	    } catch (System.Exception e){
	        System.debug('ABSILOG *** ERROR:' + e);
	    }		
		while (reader.hasNext()) {
			if (reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'EVENT') {
				WTRACE_TandTElement.WTRACE_TandT_Event myTandTEvent = new WTRACE_TandTElement.WTRACE_TandT_Event();
				parseEvent(reader,myTandTEvent);
				myElement.myTandTEvents.add(myTandTEvent);			
			}
			reader.next();
		}
		return;
	}
	
	private void parseEvent(XmlStreamReader reader,WTRACE_TandTElement.WTRACE_TandT_Event myTandTEvent) {
				while(reader.hasNext()) {
					if (reader.getEventType() == XmlTag.END_ELEMENT && reader.getLocalName() == 'EVENT') {
						break;
					}
					else if (reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'EVENTCODE') {
						reader.next();
						if (reader.getEventType() == XmlTag.CHARACTERS) {
							String myText = reader.getText();
							myTandTEvent.eventCode = myText;
							System.debug('################# ABSILOG : myText ' + myText + '##########');
						}
					}
					else if (reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'PRODUCT') {
						reader.next();
						if (reader.getEventType() == XmlTag.CHARACTERS) {
							String myText = reader.getText();
							myTandTEvent.product = myText;
							System.debug('################# ABSILOG : myText ' + myText + '##########');
						}
					}
					else if (reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'ITEM') {
						reader.next();
						if (reader.getEventType() == XmlTag.CHARACTERS) {
							String myText = reader.getText();
							myTandTEvent.item = myText;
							System.debug('################# ABSILOG : myText ' + myText + '##########');
						}
					}
					else if (reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'LOCATION') {
						reader.next();
						if (reader.getEventType() == XmlTag.CHARACTERS) {
							String myText = reader.getText();
							myTandTEvent.location = myText;
							System.debug('################# ABSILOG : myText ' + myText + '##########');
						}
					}
					else if (reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'HANDLER') {
						reader.next();
						if (reader.getEventType() == XmlTag.CHARACTERS) {
							String myText = reader.getText();
							myTandTEvent.handler = myText;
							System.debug('################# ABSILOG : myText ' + myText + '##########');
						}
					}
					else if (reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'ACTUALDATE') {
						reader.next();
						if (reader.getEventType() == XmlTag.CHARACTERS) {
							String myText = reader.getText();
							myTandTEvent.actualDate = myText;
							System.debug('################# ABSILOG : myText ' + myText + '##########');
						}
					}
					else if (reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'BUSINESSDATE') {
						reader.next();
						if (reader.getEventType() == XmlTag.CHARACTERS) {
							String myText = reader.getText();
							myTandTEvent.businessDate = myText;
							System.debug('################# ABSILOG : myText ' + myText + '##########');
						}
					}										
					reader.next();
				}
		
	}
}