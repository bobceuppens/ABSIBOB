/**
 After insert handler on task Sobject
*/
public with sharing class TaskAfterInsertHandler implements Triggers.Handler {
	List<Task> triggerTasks = Trigger.new;
	public void handle() {
		for(Task task:triggerTasks){
			System.debug(LoggingLevel.INFO, '### ABSI LOGS task.WhoId ' + task.WhoId );
		}
	}
}