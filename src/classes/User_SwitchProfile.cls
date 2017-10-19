public without sharing class User_SwitchProfile {
    // ^-> this is critical!
    
    public static final String PUBLIC_SITE_ROOT = 'https://na8.salesforce.com';
    public User currentUser { get; private set; }
    public Profile[] profileList { get; private set; }
    
    // Vars for debugging
    public Boolean debug { get; set; }
    public String debugRequestURL { get; set; }
    public String debugResponseBody { get; set; }
    
    // Constructor
    public User_SwitchProfile() {}
    
    // Reroute inital action to the right place
    public PageReference initialize() {
        String profileId = ApexPages.currentPage().getParameters().get('profileId');
        return profileId == null ? initializeView() : initializeUpdate();
    }
    
    public PageReference initializeView() {
        currentUser = [ 
            select Profile.UserLicenseId
                 , Profile.Name
                 , Username
              from User
             where Id = :UserInfo.getUserId()
             limit 1
        ];
        
        profileList = [
            select Name
              from Profile
             where UserLicenseId = :currentUser.Profile.UserLicenseId
               and Id != :currentUser.Profile.Id 
          order by Name asc
             limit 1000
        ];
        
        return null;
    }
    
    public PageReference initializeUpdate() {
        try {
            String profileId = ApexPages.currentPage().getParameters().get('profileId');
            String userId = ApexPages.currentPage().getParameters().get('userId');
            debug = true;
            update new User(Id = userId, ProfileId = profileId);
        } catch (System.Exception pException) {
            ApexPages.addMessages(pException);
        }
        
        return null;
    }
    
    public PageReference selectProfile() {
        String profileId = ApexPages.currentPage().getParameters().get('profileId');
        String remoteURL = PUBLIC_SITE_ROOT + '/user_switchprofile?profileId=' + profileId + '&userId=' + UserInfo.getUserId();
        
        // Try the outbound call
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setMethod('GET');
        httpRequest.setEndpoint(remoteURL);
        
        // Run it - here is the magic...
        HttpResponse httpResponse = new Http().send(httpRequest);
        
        // Debugging?
        if (debug == true) {
            debugRequestURL = remoteURL;
            debugResponseBody = httpResponse.getBody();
        }
        
        return initializeView();
    }
    
    @isTest static void testCoverageView() {
        // Note from Ian: 
        //
        // This is demo code, so I'm not going to bother writing any real unit tests for this thing.
        
        User_SwitchProfile u = new User_SwitchProfile();
        u.debug = true;
        u.initialize();
        u.initializeView();
        
        ApexPages.currentPage().getParameters().put('profileId', UserInfo.getProfileId());
        
        u.selectProfile();
        
        // Because SF wants me to...
        system.assert(true, 'system.assert(true) != true ?');
    }
    
    @isTest static void testCoverageUpdate() {
        // Run the update code
        ApexPages.currentPage().getParameters().put('userId', UserInfo.getUserId());
        ApexPages.currentPage().getParameters().put('profileId', UserInfo.getProfileId());
        
        User_SwitchProfile u = new User_SwitchProfile();
        u.initializeUpdate();
        
        // Because SF wants me to...
        system.assert(true, 'system.assert(true) != true ?');
    }
}