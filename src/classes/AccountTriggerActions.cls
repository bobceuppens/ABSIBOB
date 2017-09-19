public with sharing class AccountTriggerActions {

	public static void changeValue(Map<Id, Account> newAccounts) {
		for(Account myAccount:newAccounts.values()) {
			System.debug('ABSILOG *** Trigger.isBefore *** Account name ' + myAccount.Name + ' ################');
			if (myAccount.Name == 'Sven') {
				myAccount.Name = 'Bob';
			}
		}
	}

	public static void checkValue(Map<Id, Account> oldAccounts,Map<Id, Account> newAccounts) {
		for(Account newAccount:newAccounts.values()){
			Account oldAccount = oldAccounts.get(newAccount.Id);
			System.debug('ABSILOG *** Trigger.isAfter *** Account old name ' + oldAccount.Name + ' ################');
			System.debug('ABSILOG *** Trigger.isAfter *** Account new name ' + newAccount.Name + ' ################');
		} 
	}
}