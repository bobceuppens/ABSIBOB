public class WebServiceHelper {
    public String getSessionId(){
            String sessionId;
            String endpointLogin = 'https://test.salesforce.com/services/Soap/c/30.0';
            String loginRequest = '<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:enterprise.soap.sforce.com\"> <soapenv:Header> </soapenv:Header> <soapenv:Body><urn:login> <urn:username>bob.ceuppens@kone.com.devint</urn:username> <urn:password>absi0000</urn:password></urn:login> </soapenv:Body></soapenv:Envelope>';
            HttpRequest req = new HttpRequest();
            req.setEndpoint(endpointLogin);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'text/xml;charset=UTF-8');
            req.setHeader('SOAPAction', '\"\"');
            req.setbody(loginRequest);
            Http http = new Http();
            HTTPResponse response = http.send(req);
            System.debug(' ------ ' + response.getbody());

            boolean isSafeToGetNextXmlElement = true;
            XmlStreamReader reader = new XmlStreamReader(response.getbody());
            while(isSafeToGetNextXmlElement) {
                if (reader.getEventType() == XmlTag.START_ELEMENT) {
                    if ('sessionId' == reader.getLocalName()) {
                        reader.next();
                        sessionId = reader.getText();
                        System.debug('******************* sessionId ' + sessionId);
                    }
                }
                if (reader.hasNext()) {
                    reader.next();
                } else {
                    isSafeToGetNextXmlElement = false;
                    break;
                }
            }
            return sessionId;
    }
}