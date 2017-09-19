/**
 * Creation Date: 	20110118
 * Description: 	NMP_AlertBuilder - Generic class to build an EmailVision NMP request
 * 
 * Author: 	ABSI - Bob Ceuppens
 */	

public with sharing class WS_Outbound_Tester {
	
		String to;
		String myNMPRequest;
		 
		
		@future (callout=true)
		public static void send(Map<String,String> NMPValuesIn,String to,String securityTag,String randomTag,String notificationId) {
		
			Http h = new Http();

	        HttpRequest req = new HttpRequest();
	        req.setEndpoint('http://api.notificationmessaging.com/nsapi/services/NotificationService');
	        req.setMethod('POST');
	        req.setTimeout(60000);
	        
	        //req.setBody(WS_Outbound_Tester.buildNMPRequest(NMPValuesIn,to,securityTag,randomTag,notificationId));
	        
	        req.setBody('<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"> <soapenv:Body>  <notifications xmlns="http://soap.sforce.com/2005/09/outbound">   <OrganizationId>00D20000000NKTKEA4</OrganizationId>   <ActionId>04k20000000XZBPAA4</ActionId>   <SessionId>00D20000000NKTK!AR0AQNB8sHQuvgeb8t2ClO74yHPGbUqjjBdPEBKYEdlXmh_WTCmAtkBgVFhQHcvTYPEPXqZBfx2oV0UIi5uwmba2MiYa9IZF</SessionId>   <EnterpriseUrl>https://eu0-api.salesforce.com/services/Soap/c/19.0/00D20000000NKTK</EnterpriseUrl>   <PartnerUrl>https://eu0-api.salesforce.com/services/Soap/u/19.0/00D20000000NKTK</PartnerUrl>   <Notification>    <Id>04l20000006K4cwAAC</Id>    <sObject xmlns:sf="urn:sobject.enterprise.soap.sforce.com" xsi:type="sf:Project__c">     <sf:Id>a062000000MDgUNAA1</sf:Id>     <sf:Name>689017</sf:Name>    </sObject>   </Notification>  </notifications> </soapenv:Body></soapenv:Envelope>');
	        HttpResponse res = h.send(req);
	        
	        System.debug('################# res : ' + res + '##########""');
		}
	
	public static String buildNMPRequest(Map<String,String> NMPValuesIn,String to,String securityTag,String randomTag,String notificationId) {
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