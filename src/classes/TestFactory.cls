@IsTest
public class TestFactory {
    public static User createStandardUser(){
        User u = new User(
            Alias = 'standt', 
            Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', 
            LastName='Testing', 
            UserRoleId='00E20000000huXR',
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', 
            TimeZoneSidKey='America/Los_Angeles', 
            UserName='standarduser112233@testorg.com'
            );
        return u;
    }
}