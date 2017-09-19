/************************************
* @author       :    Bob Ceuppens
* @since        :    09 2013
* @description  :    Web Service listener class to integrate with Sitecore.
*************************************/

global class testWS {

    global class SayHelloWorldRequest {
        webService String contactId;
        webService String gender;
        webService String firstName;
        webService String lastName;
        webService String company;
        webService String jobTitle;
        webService String jobRole;
        webService String emailAddress;
        webService String industry;
        webService String linkedIn;
        webService String twitter;
        webService String street;
        webService String streetNumber;
        webService String box;
        webService String postalCode;
        webService String city;
        webService String country;
        webService String newsletterSubscribe;
        webService String newsletterLanguage;
        webService String domainsOfInterest;
        webService String otherDomainOfInterest;
        webService String servicesOfInterest;
        webService String optOut;
    }

    webService static String sayHelloWorld(SayHelloWorldRequest theRequest) {
        return 'SUCCESS';
    }

}