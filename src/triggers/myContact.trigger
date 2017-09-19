trigger myContact on Contact (after update) {
    Contact [] accs = Trigger.new;
    //MyHelloWorld.addHelloWorld(accs);
    //testContactUpdater.contactUpdater();
    
    // Provoke error on purpose to test behaviour
    Contact [] accs2 = null;
    System.debug('ABSILOG *** accs.size() ' + accs.size() + ' ################') ;
}