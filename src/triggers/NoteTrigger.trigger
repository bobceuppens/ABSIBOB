trigger NoteTrigger on Note (before insert) {
	// Send an email to the Apex job's submitter notifying of job completion.  
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
String[] toAddresses;
toAddresses = new String[] {'bob1@absi.be','bob2@absi.be','bob3@absi.be'};
mail.setToAddresses(toAddresses);
mail.setSubject('Test email limits');
mail.setPlainTextBody('Test email limits');
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

}