@RestResource(urlMapping='/FieldCase/*')
global class REST_Account {

@HttpPost	
  global static String createNewCase(RestRequest req) {
		System.debug('ABSILOG *** RestRequest: '+ req.requestBody.toString ());
		
		return 'Successful request';
	}
}