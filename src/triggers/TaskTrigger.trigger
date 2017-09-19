/**
 Trigger on Task Sobject
*/
trigger TaskTrigger on Task (after delete, after insert, after undelete, 
                             after update, before delete, 
                             before insert, before update) {
    
 
    new Triggers()
        //.bind(Triggers.Evt.afterinsert,  new TaskAfterInsertHandler())
        // bind first before insert handler
        //.bind(Triggers.Evt.beforeinsert, new TaskBeforeInsertHandler())
        // bind another before insert handler, that will execute after the first one.
        // All you need to do is add handlers in the correct order here 
        /*
        .bind(Triggers.Evt.beforeinsert, new TaskBeforeInsertHandler2())
        .bind(Triggers.Evt.afterupdate, new TaskAfterUpdateHandler())
        */
        // Done with adding all handlers, lets call the manage now for once only
        .manage();
 
}