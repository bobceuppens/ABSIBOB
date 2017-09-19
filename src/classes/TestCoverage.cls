/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest(SeeAllData=true)
public with sharing class TestCoverage {
      public static TestMethod void XMLTest() {
        Id userId = '00580000001d8FZ';
        User myUser = [SELECT Id FROM user WHERE Id=:userId];
        Schema.PicklistEntry[] pes = Schema.SObjectType.User.fields.LocaleSidKey.PicklistValues;
        for (Schema.PicklistEntry a : pes) { //for all values in the picklist list
          //for (Integer i = 1; i < 10; i++) {
            if (a.getValue().startsWith('d') || a.getValue().startsWith('n') || a.getValue().startsWith('e') ) {
            myUser.LocaleSidKey=a.getValue();
            update myUser;
            System.runAs(myUser) {
              Decimal value = 1000.10;
              String formattedValue = value.format();
              String thousandSep = formattedValue.substring(1,2);
              String decimalSep = formattedValue.substring(5,6);
              System.debug('############ ABSILOG - a.getLabel() / a.getValue() / thousandSep / decimalSep ' + a.getLabel() + ' / ' + a.getValue() + ' / ' + formattedValue + ' / ' + thousandSep + ' / ' + decimalSep + ' ###########');
			  
			  datetime myDate = datetime.now(); 
			  System.debug('############ ABSILOG myDate.format() ' + myDate.format() +  ' ###########');
            }
          //}
        }
      }
    }
}