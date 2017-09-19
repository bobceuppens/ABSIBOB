trigger Account_AI_AU on Account (after insert, after update) {
    
    System.debug('ABSILOG *** System.Trigger.new.size() ' + System.Trigger.new.size() + ' ################') ;
    // Provoke error on purpose to test behaviour
    for(Account account : System.Trigger.new){
        System.debug('ABSILOG *** account.id' + account.Id + ' account.name ' + account.name + ' ################') ;
    }
}