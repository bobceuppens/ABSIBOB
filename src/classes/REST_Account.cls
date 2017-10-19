@RestResource(urlMapping='/FieldCase/*')
global class REST_Account {

@HttpPost
  global static String createNewCase() {
		System.debug('ABSILOG *** RestRequest: '+ RestContext.request.requestBody.toString ());
		
		return 'Successful request';
	}
}