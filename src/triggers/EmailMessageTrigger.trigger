trigger EmailMessageTrigger on EmailMessage (after update) {

    for(Integer i=0; i < trigger.new.size() ; i++) {
        System.debug(Logginglevel.DEBUG,'ABSILOG *** ' + trigger.new[i].status);
    }
}