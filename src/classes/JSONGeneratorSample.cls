public class JSONGeneratorSample{
    
    public String generateJSON {get; set;}
    public final Account acct;

    public class A { 
        String str;
        public A(String s) { str = s; }
    }
    
    public JSONGeneratorSample(ApexPages.StandardController controller) {
        this.acct = (Account)controller.getRecord();
        Account myAccount = [SELECT Id, Name,BillingAddress,BillingCity,BillingCountry,BillingCountryCode FROM Account Where Id=:this.acct.Id];
        generateJSON = JSON.serializePretty(myAccount );
        System.debug(LoggingLevel.INFO,'ABSILOG *** generateJSON  ' + generateJSON );
    }
        
    public JSONGeneratorSample() {
        // Create a JSONGenerator object.
        // Pass true to the constructor for pretty print formatting.
        JSONGenerator gen = JSON.createGenerator(true);
        
        // Create a list of integers to write to the JSON string.
        List<integer> intlist = new List<integer>();
        intlist.add(1);
        intlist.add(2);
        intlist.add(3);
        
        // Create an object to write to the JSON string.
        A x = new A('X');
        
        // Write data to the JSON string.
        gen.writeStartObject();
        gen.writeNumberField('abc', 1.21);
        gen.writeStringField('def', 'xyz');
        gen.writeFieldName('ghi');
        gen.writeStartObject();
        
        gen.writeObjectField('aaa', intlist);
        
        gen.writeEndObject();
        
        gen.writeFieldName('Object A');
        
        gen.writeObject(x);
        
        gen.writeEndObject();
        
        // Get the JSON string.
        String pretty = gen.getAsString();
        
        generateJSON = pretty;
        
        System.debug(LoggingLevel.INFO,'ABSILOG *** generateJSON  ' + generateJSON );
      }
}