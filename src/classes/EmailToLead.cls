global class EmailToLead implements Messaging.InboundEmailHandler {
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, 
   Messaging.InboundEnvelope env){
    // Create an InboundEmailResult object for returning the result of the  
    // Apex Email Service 
    Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
    String myPlainText= '';

    // Add the email plain text into the local variable  
    myPlainText = email.plainTextBody;


    Map<Integer,String> emailMapping = new Map<Integer,String>();
    emailMapping.put(1,'FirstName');
    emailMapping.put(2,'LastName');
    emailMapping.put(3,'Email');
    emailMapping.put(4,'Company');

    Map<String,String> emailBodyValues = new Map<String,String>();

    String[] emailBody = email.plainTextBody.split('\n', 0);
    System.debug(LoggingLevel.INFO,'ABSILOG ***  email.plainTextBody ' + email.plainTextBody);
    for (Integer i=0;i<emailBody.size();i++) {
      String bodyPart = emailBody.get(i);
      emailBodyValues.put(emailMapping.get(i+1),bodyPart);
      System.debug(LoggingLevel.INFO,'ABSILOG ***  bodyPart ' + bodyPart);
    }
    System.debug(LoggingLevel.INFO,'ABSILOG ***  emailBodyValues ' + emailBodyValues);

       // Check for existing leads with this email address   
    Lead[] leads = [SELECT Id, Name, Email
    FROM Lead
    WHERE Email = :emailBodyValues.get('Email')];
    
    if (leads.size() == 0) {
      // Insert a new lead
      // New Lead object to be created - set LastName and Company to
      // dummy values for simplicity
      Lead newLead = new Lead(Email = emailBodyValues.get('Email'), 
        FirstName = emailBodyValues.get('FirstName'),
        LastName = emailBodyValues.get('LastName'),
        Company = emailBodyValues.get('Company')
      );

      insert newLead;    

    } else {
      //System.debug('Incoming email duplicates existing Lead record(s): ' + leads );    
    }

    // Set the result to true. No need to send an email back to the user      
    // with an error message   
    result.success = true;

    // Return the result for the Apex Email Service 
    return result;
  }
}