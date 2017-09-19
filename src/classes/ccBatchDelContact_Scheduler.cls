/**********************************************************************
 Name: ccBatchDelNotifications_Scheduler
 Other classes used:
======================================================
Description: 

***********************************************************************/
global class ccBatchDelContact_Scheduler implements Schedulable 
{   
    global void execute(SchedulableContext sc) {
        database.executebatch(new batchDeleteRecords('SELECT Id FROM Contact WHERE Name like \'X%\' LIMIT 1'));
    }   
}