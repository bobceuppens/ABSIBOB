public class testXML {

   public class TempAccount {
      String name;
      String address;
   }
   
   TempAccount[] parseAccounts(XMLStreamReader reader) {
       TempAccount[] accts = new TempAccount[0];
       while (reader.hasNext()) {
           if (reader.getEventType() == XmlTag.START_ELEMENT) {
              if(reader.getLocalName() == 'account') {
                 accts.add(parseAccount(reader));
               }
            }
            reader.next();
          }
        return accts;
     }

      TempAccount parseAccount(XmlStreamReader reader) {
          TempAccount tmpacct = new TempAccount();
           tmpacct.name = reader.getAttributeValue('', 'name');
           while(reader.hasNext()) {
                if (reader.getEventType() == XmlTag.END_ELEMENT) {
                       break;
                } else if (reader.getEventType() == XmlTag.CHARACTERS) {
                       tmpacct.address = reader.getText();
                 }
                 reader.next();
            }
          return tmpacct;
        }

}