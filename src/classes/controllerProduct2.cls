public with sharing class controllerProduct2 {
	
	
	// current controller
	private final ApexPages.StandardController controller;
	
	// Current record
	private Product2 currentProduct;
	
	public Product2 getCurrentProduct() {
		return currentProduct;
	}
	
	public String liveInventory = '';
	
	public controllerProduct2(ApexPages.StandardController stdController) {
			this.controller  = stdController ; 
			this.currentProduct = (Product2) stdController.getRecord();
	}
	
	public void updateInventory(){
		liveInventory = this.getLookupResponse();
	}
	
	public String getLiveInventory() {
		return liveInventory;
	}

	public void setLiveInventory(String liveInventoryIn) {
		liveInventory = liveInventoryIn;
	}
	
	public String getLookupResponse() {
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://80.65.128.7:8081/DART_Live_Inventory/');
        req.setMethod('POST');
        req.setTimeout(60000);
        String DART_Identifier = this.getXML();
        req.setBody(DART_Identifier);
        HttpResponse res = h.send(req);
        return res.getBody();
    }
    
    public String getXML() {
		  XmlStreamWriter w = new XmlStreamWriter();
		  Integer i=0;
	      w.writeStartElement(null, 'Product', null);
	      w.writeStartElement(null, 'Id', null);
	      w.writeCharacters(currentProduct.Id);
          w.writeEndElement();
          w.writeEndElement();
          w.writeEndDocument();
          String xmlOutput = w.getXmlString();
          w.close();
          return xmlOutput;
		
	}


	
}