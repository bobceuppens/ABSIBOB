public without sharing class myController {
    public static String getCountryAccess() {
        User user = [SELECT Id, UserRoleId,UserRole.DeveloperName,Username FROM User WHERE Id = :Userinfo.getUserId()];
        system.debug('user id ' + user.Id);
        return user.username;
    }
}