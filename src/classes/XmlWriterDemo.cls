global with sharing class XmlWriterDemo  {

   Webservice Static String getRavisXml() {
            List<Contact> contacts = XmlWriterDemo.getContacts();
            String ravisXML = XmlWriterDemo.createXML(contacts);
            return ravisXML;
        }

    public static List<Contact> getContacts() {
        List<Contact> contacts = [select Id,Name from Contact limit 30];
        return contacts;
    }
    
    public static String createXML(List<Contact> contacts) {
          XmlStreamWriter w = new XmlStreamWriter();
          Integer i=0;
          w.writeStartElement(null, 'Graph', null);
          for (Contact contact:contacts) {
            w.writeStartElement(null, 'Node', null);
            w.writeAttribute(null, null, 'id', String.valueOf(i));
            w.writeAttribute(null, null, 'name', contact.Name);
            w.writeAttribute(null, null, 'nodeColor', '0x333333');
            w.writeAttribute(null, null, 'nodeSize', '25');
            w.writeEndElement(); //end Node
            i = i + 1;
          }
          w.writeStartElement(null, 'Node', null);
          w.writeAttribute(null, null, 'id', '2');
          w.writeAttribute(null, null, 'name', 'ABSI SF TEST ACCOUNT');
          w.writeAttribute(null, null, 'nodeColor', '0x333333');
          w.writeAttribute(null, null, 'nodeSize', '25');
          w.writeEndElement(); //end Node
          w.writeStartElement(null, 'Edge', null);
          w.writeAttribute(null, null, 'fromID', '1');
          w.writeAttribute(null, null, 'toID', '2');
          w.writeAttribute(null, null, 'edgeLabel', 'Affiliation');
          w.writeAttribute(null, null, 'color', '0x000000');
          w.writeEndElement(); //end Edge                      
          w.writeEndElement(); //end Graph
          w.writeEndDocument();
          String xmlOutput = w.getXmlString();
          w.close();
          return xmlOutput;
        
    }
    
    public static String buildXML2(Map<String,String> NMPValuesIn,String to,String securityTag,String randomTag,String notificationId) {
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
            for (String myKey:NMPKeys) {
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
    
    public static String createXML(String XMLVaueIn) {
          XmlStreamWriter w = new XmlStreamWriter();
          Integer i=0;
          w.writeStartElement(null, 'DATA', null);
          w.writeAttribute(null, null, 'id', '2');
          w.writeEndElement(); //end Graph
          w.writeEndDocument();
          String xmlOutput = w.getXmlString();
          w.close();
          return xmlOutput;
        
    }
    
    public static String buildXML() {
    
            XmlStreamWriter w = new XmlStreamWriter();
            w.writeStartElement(null, 'Name', null);
            
            w.writeCharacters('Bob');
            w.writeEndElement();
            
            String xmlOutput = w.getXmlString();
            
            System.debug('################# xmlOutput : ' + xmlOutput + '##########""');
            
            w.close();
            return xmlOutput;
    }   
}