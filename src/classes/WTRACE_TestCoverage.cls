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
public with sharing class WTRACE_TestCoverage {
  
    public static TestMethod void XMLTest() {

      WTRC_Shipment__c myShipment = new WTRC_Shipment__c();
/*      
      insert myShipment;
*/
      // For development hardcoded to SHIP-000002
      List<WTRC_Shipment__c> myShipments = [select Id from WTRC_Shipment__c Where Id =: 'a05C000000AYVJF'];
      
/*      
      myShipments.add(myShipment);
      
      String mySOQL = Util.getSOQL('WTRC_Shipment__c',new List<Id>{myShipment.Id});
    try {
            myShipments = database.query(mySOQL);
    } catch (QueryException e){
            //perform exception handling
    }
    
    List<sObject> mysObjects = Util.getSobjects('WTRC_Shipment__c',new List<Id>{myShipment.Id});
    myShipments = (List<WTRC_Shipment__c>) mysObjects;
*/    

    myShipment = myShipments.get(0);

      Set <String> fieldsToExclude = new Set<String>();
      fieldsToExclude.add('wtrace_xml__c');
/*      
      String myXML = WTRC_XMLBuilder.getXML(myShipments,fieldsToExclude);
      System.debug('################# ABSILOG : myXML ' + myXML + ' ##########');
*/      
      PageReference pageRef = new PageReference('/' + myShipment.id);
      pageRef.getParameters().put('id',myShipment.id);
      Test.setCurrentPage(pageRef);
      ApexPages.StandardController sct = new ApexPages.StandardController(myShipment); //set up the standardcontroller
     WTRACE_controllerLabelPrinter myController = new WTRACE_controllerLabelPrinter(sct);
    myController.submitShipment();
    }
}