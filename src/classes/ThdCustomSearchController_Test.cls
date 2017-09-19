@IsTest
private class ThdCustomSearchController_Test {

    static
    {
        User us = testFactory.createStandardUser();
        insert us;
    }
    
    static testMethod void getCountryAccess_KMERole() {
        List<User> us =[Select Id from User where UserName='standarduser112233@testorg.com'];
        system.runAs(us[0]){
            Test.startTest();
            String usercountry = myController.getCountryAccess();
            Test.stopTest();
            system.assert(usercountry.contains('USA'));
        }

    }

}