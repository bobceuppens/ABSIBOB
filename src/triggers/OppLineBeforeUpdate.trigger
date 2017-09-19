trigger OppLineBeforeUpdate on OpportunityLineItem (before insert, before update) {
	
	OpportunityLineItem [] myOppLines=new OpportunityLineItem[]{};
	myOppLines=Trigger.new;
	system.debug('****************************** oppId.size : '+myOppLines.size()+'*******************************');
	Opportunity []opp=[Select o.Id,o.RecordTypeId,o.StageName From Opportunity o where 
				(o.RecordTypeId =: FinalConstants.opptyRecordTypeCPC
				or o.RecordTypeId =: FinalConstants.opptyRecordTypeCPCgek)
				and o.StageName =:FinalConstants.closedWon];
	system.debug('****************************** oppId.size : '+opp.size()+'*******************************');
    /*
    *
    * Set ids of Opportunities ClosedWon 
    * to get all OpportunityLineItem with this Id
    */
    set<Id> oppIds=new set<Id>{};
    
    for(Opportunity myOpp : opp)
    {
    	oppIds.add(myOpp.Id);
    	
    }
    /*
    *
    * Query on OpportunityLineItem with their Opportunity on ClosedWon and RecordType=CPC 
    * and checks if the product is the same within the same period 
    * 
    */
    
    system.debug('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX myOppLines.size: '+myOppLines.size()+' XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    //system.debug('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXmyOppLines : '+myOppLines.PricebookEntry.Product2Id+' XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    OpportunityLineItem curOppLine = myOppLines.get(0);
    system.debug('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX curOppLine: '+ curOppLine + ' XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    system.debug('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX curOppLine.PricebookEntryId: '+ curOppLine.PricebookEntryId + ' XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    system.debug('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX curOppLine.PricebookEntry.Product2.Name: '+ curOppLine.PricebookEntry.Product2.Name + ' XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    
    PricebookEntry[] myPricebookEntries = [Select p.UnitPrice,p.Product2.Name,p.Product2.Description, p.Product2.SiteName__c, p.Product2.Family, p.Product2.CreatedDate, p.Product2.IsActive, p.Product2Id, p.Name, p.Id From PricebookEntry p  where Id =: '01u80000001tJkzAAE'];
    
    PricebookEntry myPricebookEntry =  myPricebookEntries.get(0);
    
    system.debug('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX curOppLine.PricebookEntry.Product2.Name: '+ myPricebookEntry.Product2.Name + ' XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    
    myPricebookEntry.Product2.Description = System.now().format(); 
    
    update myPricebookEntry.Product2;
    
}