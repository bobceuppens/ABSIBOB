public with sharing class controllerWS_Tester {


	public String AccountId {get;set;}
	
	public String CustomerCode {get;set;}
	
	public WS_Navision_DTO Navision_DTO {get;set;}
	
	// Account called by the vf page ! 
    private Account Acc ;
    public Account getAcc(){return this.acc;}
    public void setAcc(Account a){this.acc = a ; }
    
	private WS_Navision_AmountsDue.ResponseOUT_element amountsDue;
	public WS_Navision_AmountsDue.ResponseOUT_element getAmountsDue() {return this.amountsDue;}
	public void setAmountsDue(WS_Navision_AmountsDue.ResponseOUT_element amountsDueIn){this.amountsDue = amountsDueIn;}
	
	public controllerWS_Tester() {
	}
		
	public controllerWS_Tester(ApexPages.StandardController stdController) {
		Acc = (Account) stdController.getRecord();
		
		System.debug('################# Acc : ' + Acc + '##########""');
	}
	
	 public List<SelectOption> getHours() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('01','01'));
            options.add(new SelectOption('02','02'));
            options.add(new SelectOption('03','03'));
            return options;
	}
            
	public void parseAmountsDue() {
		CustomerCode = amountsDue.CustomerCode;
	}
	
	public void callWS(){
		
		Http h = new Http();
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://api.notificationmessaging.com/nsapi/services/NotificationService');
        req.setMethod('POST');
        req.setTimeout(60000);
        
        //String myRequest = this.buildXML();
        String myRequest = this.getNMPRequest();
        req.setBody(myRequest);
        
        HttpResponse res = h.send(req);
        
        System.debug('################# res : ' + res + '##########""');
	}
	
	public void init() {
		
	}
	
	public void getWSNavisionAmountsDue(){
		
		WS_Navision_Binding.BasicHttpBinding_ITwoWayAsync myWS_stub = new WS_Navision_Binding.BasicHttpBinding_ITwoWayAsync();
		myWS_stub.timeout_x = 10000;
		amountsDue = myWS_stub.getAmountsDue('CU0020632');
		Navision_DTO = new WS_Navision_DTO();
		Navision_DTO.bindData(amountsDue);
		System.debug('################# ABSILOG : myAmountsDue ' + amountsDue + '##########');
	}

	public void getWSNavisionPrices(){
		
		WS_Navision_Binding.BasicHttpBinding_ITwoWayAsync myWS_stub = new WS_Navision_Binding.BasicHttpBinding_ITwoWayAsync();
		myWS_stub.timeout_x = 10000;
		WS_Navision_Prices.ResponseOUT_element myPrice = myWS_stub.getPricesAndDiscounts('CU0015207','NL');
		Navision_DTO = new WS_Navision_DTO();
		Navision_DTO.bindData(myPrice);
		System.debug('################# ABSILOG : myPrice ' + myPrice + '##########');
	}	
	   public String buildXML(){
 	
 		XmlStreamWriter w = new XmlStreamWriter();
        w.writeStartElement(null, 'Name', null);
        
		w.writeCharacters('Joris');
        w.writeEndElement();
        
        String xmlOutput = w.getXmlString();
        
        System.debug('################# xmlOutput : ' + xmlOutput + '##########""');
        
        w.close();
        return xmlOutput;
    }
    
    public String getNMPRequest() {
    	//String myNMPRequest = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:api="http://api.service.nsapi.emailvision.com/">    <soapenv:Header/>    <soapenv:Body> <api:sendObjectsWithFullStatus>          <arg0>             <sendrequest>                <content>                   <entry>                      <key>1</key>                      <value>TEST FROM SOAPUI></value>                   </entry>                </content>                <dyn>                   <entry>                      <key>firstname</key>                      <value>Bob</value>                   </entry>                </dyn>      <email>bob@ceuppens.be</email>                <encrypt>BdX7CqkmjRfdsGZ8CZcM6c3VIUx7bduy8wzj</encrypt>                <notificationId>9131</notificationId>                <random>AFA95C272901AFA9</random>                <senddate>2008-12-12T00:00:00</senddate>                <synchrotype>UPDATE</synchrotype>                <uidkey>EMAIL</uidkey>             </sendrequest>         </arg0>       </api:sendObjectsWithFullStatus>   </soapenv:Body> </soapenv:Envelope> ';
    	String myNMPRequest = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:api="http://api.service.nsapi.emailvision.com/">	<soapenv:Header/>	<soapenv:Body>		<api:sendObjectsWithFullStatus>			<arg0>				<sendrequest>					<content>						<entry>							<key>1</key>							<value>TEST FROM SOAPUI></value>						</entry>					</content>					<dyn>						<entry>							<key>date_perso</key>							<value>date_perso </value>						</entry>						<entry>							<key>firstname</key>							<value>firstname</value>						</entry>						<entry>							<key>firstname</key>							<value>Bob</value>						</entry>						<entry>							<key>lastname </key>							<value>lastname</value>						</entry>						<entry>							<key>model_perso</key>							<value>Bob</value>						</entry>						<entry>							<key>num_perso</key>							<value>num_perso</value>						</entry>																																			</dyn>					<email>bob@ceuppens.be</email>					<encrypt>BdX7CqkmjQnkxhALB5F57szXKkx6HK3D_QuW</encrypt>					<notificationId>14347</notificationId>					<random>7067365602000007</random>					<senddate>2008-12-12T00:00:00</senddate>					<synchrotype>NOTHING</synchrotype>					<uidkey>EMAIL</uidkey>				</sendrequest>			</arg0>		</api:sendObjectsWithFullStatus>	</soapenv:Body></soapenv:Envelope>';
    	return myNMPRequest;
    }
}