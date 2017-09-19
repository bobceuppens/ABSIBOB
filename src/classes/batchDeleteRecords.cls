global class batchDeleteRecords implements Database.Batchable<sObject>{
/**********************************************************************
 Name:  batchDeleteRecords
 Other classes used: 
 Tested in class: batchDeleteRecords_Tests
======================================================
Purpose: 
Delete any scope given as input
======================================================
History                                                            
-------                                                            
VERSION    AUTHOR        DATE      DETAIL                                 
  1.0    Patrick Brinksma  15/02/2012    INITIAL DEVELOPMENT
***********************************************************************/
  
   global final String Query;

   global batchDeleteRecords(String q){
      Query=q; 
   }

   global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<sObject> scope){
     delete scope;
    }

   global void finish(Database.BatchableContext BC){
   }
}