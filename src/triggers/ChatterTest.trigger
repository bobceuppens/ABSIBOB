trigger ChatterTest on FeedItem (Before insert,Before update) {
    Set<Id> oppIds = new Set<Id>(); 
    List<Task> tasks = new List<Task>();
    List<Opportunity> opps2Update = new List<Opportunity>();
    Map<Id, Id> oppId2PostCreator = new Map<Id, Id>();

    //Get the key prefix for the Opportunity object via a describe call.
    String oppKeyPrefix = Opportunity.sObjectType.getDescribe().getKeyPrefix();
    
    for (FeedItem f : trigger.new)
    {
        String parentId = f.parentId;
        //We compare the start of the 'parentID' field to the Opportunity key prefix to
        //restrict the trigger to act on posts made to the Opportunity object.
        if (parentId.startsWith(oppKeyPrefix) && 
            f.type == 'TextPost' && 
            f.Body.startsWith('!close'))
        {            
            oppIds.add(f.parentId);
            oppId2PostCreator.put(f.parentId, f.CreatedById);
        }
    }
    
    List<Opportunity> opps = [select id, account.name, ownerId, stageName, closeDate 
                              from Opportunity 
                              where id in :oppIds];
        
    for (Opportunity o : opps)
    {
       //We compare the creator of the Chatter post to the Opportunity Owner to ensure
       //that only authorized users can close the Opportunity using the special Chatter 'hot-key'
        if (oppId2PostCreator.get(o.Id) == o.ownerId)
        {
            o.StageName = 'Closed Won';
            o.CloseDate = System.today();
    
            Task t = new Task ( OwnerId = o.OwnerId,
                                WhatId = o.Id,
                                Priority = 'High',
                                Description = 'Check-in with '+account.name,
                                Subject = 'Follow-up',
                                ActivityDate = System.today().addDays(7));  
            tasks.add(t);
            opps2Update.add(o);
        }
    }    
    
    update opps2Update;
    insert tasks;
}