/**
 Before insert handler on task Sobject
*/
public with sharing class TaskBeforeInsertHandler implements Triggers.Handler {
	List<Task> triggerTasks = Trigger.new;
	public void handle() {
		for(Task task:triggerTasks){
			System.debug(LoggingLevel.INFO, '### ABSI LOGS task.WhoId ' + task.WhoId );
			//task.WhatId = '006C000000gNpy6';
			task.WhoId = '00QC000000nXEEs';
		}
	}
}