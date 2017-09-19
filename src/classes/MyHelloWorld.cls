// This class updates the Hello field on account records that are
// passed to it.
public class MyHelloWorld {

   public static void addHelloWorld(Contact[] accs){

      for (Contact a:accs){
         if (a.Nationality__c!= 'World') {
            a.Nationality__c= 'World';
         }
      }
   }

}