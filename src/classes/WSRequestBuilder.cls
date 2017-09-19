public with sharing class WSRequestBuilder {

/**
 * Creation Date: 	20110118
 * Description: 	WSRequestBuilder - Generic class to build an EmailVision NMP request
 * 
 * Author: 	ABSI - Bob Ceuppens
 */	

		String to;
		String myNMPRequest;
		 
		
		@future (callout=true)
		public static void send(Map<String,String> NMPValuesIn,String to,String securityTag,String randomTag,String notificationId) {
		
			Http h = new Http();

	        HttpRequest req = new HttpRequest();
	        req.setEndpoint('http://api.notificationmessaging.com/nsapi/services/NotificationService');
	        req.setMethod('POST');
	        req.setTimeout(60000);
	        
	        req.setBody(WSRequestBuilder.buildRequest(NMPValuesIn,to,securityTag,randomTag,notificationId));
	        
	        HttpResponse res = h.send(req);

		      	System.runAs(new User(Id = Userinfo.getUserId())) {
		      		 System.debug('################# Userinfo.getUserId() : ' + Userinfo.getUserId() + '##########""');
		    	}		    

		    if (Test.isRunningTest()) {
		    	// start new context via system.runAs() for the same user for test code only
		      	System.runAs(new User(Id = Userinfo.getUserId())) {
		      		 System.debug('################# Userinfo.getUserId() : ' + Userinfo.getUserId() + '##########""');
		    	}
		    }

	        System.debug('################# res : ' + res + '##########""');
		}
	
	public static String buildRequest(Map<String,String> NMPValuesIn,String to,String securityTag,String randomTag,String notificationId) {
		      	System.runAs(new User(Id = Userinfo.getUserId())) {
		      		 System.debug('################# Userinfo.getUserId() : ' + Userinfo.getUserId() + '##########""');
		    	}		
	          XmlStreamWriter w = new XmlStreamWriter();
	          w.writeStartElement('soapenv', 'Envelope','http://schemas.xmlsoap.org/soap/envelope/');
	          w.writeNamespace('soapenv', 'http://schemas.xmlsoap.org/soap/envelope/');
	          w.writeNamespace('api', 'http://api.service.nsapi.emailvision.com/');
	          w.writeEmptyElement('soapenv', 'Header', '');
	          w.writeStartElement('soapenv', 'Body', '');
	          w.writeStartElement('api', 'sendObjectsWithFullStatus', '');
	          w.writeStartElement(null, 'arg0', null);
	          w.writeStartElement(null, 'sendrequest', null);
	          w.writeStartElement(null, 'content', null);
	          w.writeStartElement(null, 'entry', null);
	          w.writeStartElement(null, 'key', null);
	          w.writeCharacters('1');
	          w.writeEndElement(); //END key
	          w.writeStartElement(null, 'value', null);
	          w.writeCharacters('TEST FROM SOAPUI');
	          w.writeEndElement(); //END value
	          w.writeEndElement(); //END entry
	          w.writeEndElement(); //END content
			  w.writeStartElement(null, 'dyn', null);
			
			/*
			* This loop puts all the key/value pairs in the alert
			*/
			Set<String> NMPKeys = NMPValuesIn.keySet(); 
			System.debug('################# NMP_AlertBuilder - NMPKeys ' +  NMPKeys + '##########');
			System.debug('################# NMP_AlertBuilder - NMPValuesIn ' +  NMPValuesIn + '##########');
			for (String myKey:NMPKeys) {
			  System.debug('################# NMP_AlertBuilder - myKey ' +  myKey + '##########');
			  w.writeStartElement(null, 'entry', null);
	          w.writeStartElement(null, 'key', null);
	          w.writeCharacters(myKey);
	          w.writeEndElement(); //END key
	          w.writeStartElement(null, 'value', null);
	          w.writeCharacters(NMPValuesIn.get(myKey));
	          w.writeEndElement(); //END value
	          w.writeEndElement(); //END entry
			}
			  
			  w.writeEndElement(); //END dyn
			  
			  w.writeStartElement(null, 'email', null);
	          w.writeCharacters(to);
	          w.writeEndElement(); //END email

			  w.writeStartElement(null, 'encrypt', null);
	          w.writeCharacters(securityTag);
	          w.writeEndElement(); //END encrypt
			  
			  w.writeStartElement(null, 'notificationId', null);
	          w.writeCharacters(notificationId);
	          w.writeEndElement(); //END notificationId

			  w.writeStartElement(null, 'random', null);
	          w.writeCharacters(randomTag);
	          w.writeEndElement(); //END random

			  w.writeStartElement(null, 'senddate', null);
	          w.writeCharacters('2008-12-12T00:00:00');
	          w.writeEndElement(); //END senddate

			  w.writeStartElement(null, 'synchrotype', null);
	          w.writeCharacters('NOTHING');
	          w.writeEndElement(); //END synchrotype

			  w.writeStartElement(null, 'uidkey', null);
	          w.writeCharacters('EMAIL');
	          w.writeEndElement(); //END uidkey

			  
	          w.writeEndElement(); //END sendrequest
	          w.writeEndElement(); //END arg0
	          w.writeEndElement(); //END sendObjectsWithFullStatus
	          w.writeEndElement(); //END Body
	          
		      w.writeEndDocument(); //END Envelope
	          String xmlOutput = w.getXmlString();
	          w.close();
	          return xmlOutput;
        }
		
}