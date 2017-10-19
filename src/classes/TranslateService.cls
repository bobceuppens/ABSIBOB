/*
    Copyright (c) 2008 salesforce.com, inc.
    All rights reserved.
    
    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions
    are met:
    
    1. Redistributions of source code must retain the above copyright
       notice, this list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright
       notice, this list of conditions and the following disclaimer in the
       documentation and/or other materials provided with the distribution.
    3. The name of the author may not be used to endorse or promote products
       derived from this software without specific prior written permission.
    
    THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR
    IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
    OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
    IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, 
    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
    NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
    DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
    THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
    
    Utility class for collecting a google auth sub session token for use with all 
    Google Data API's
*/
public class TranslateService {

	map<string,string>  Languages = new map<string,string>{
	  'ARABIC' => 'ar',
	  'BULGARIAN' => 'bg',
	  'CHINESE' => 'zh',
	  'CHINESE_S' => 'zh-CN',
	  'CHINESE_T' => 'zh-TW',
	  'CROATIAN' => 'hr',
	  'CZECH' => 'cs',
	  'DANISH' => 'da',
	  'DUTCH'=> 'nl',  
	  'ENGLISH' => 'en',
	  'FILIPINO' => 'tl',
	  'FINNISH' => 'fi',
	  'FRENCH' => 'fr',
	  'GERMAN' => 'de',
	  'GREEK' => 'el',
	  'HEBREW' => 'iw',
	  'HINDI' => 'hi',
	  'INDONESIAN' => 'id',
	  'ITALIAN' => 'it',
	  'JAPANESE' => 'ja',
	  'KOREAN' => 'ko',
	  'LATVIAN' => 'lv',
	  'LITHUANIAN' => 'lt',
	  'NORWEGIAN' => 'no',
	  'POLISH' => 'pl',
	  'PORTUGUESE' => 'pt-PT',
	  'ROMANIAN' => 'ro',
	  'RUSSIAN' => 'ru',
	  'SERBIAN' => 'sr',
	  'SLOVAK' => 'sk',
	  'SLOVENIAN' => 'sl',
	  'SPANISH' => 'es',
	  'SWEDISH' => 'sv',
	  'UKRAINIAN' => 'uk',
	  'VIETNAMESE' => 'vi',
	  '--None--' => ''
	};
	
	public list <SelectOption> LanguageOptions { get { 
		if (LanguageOptions == null ) {
			LanguageOptions = new list <SelectOption>();
			list<string> s = new list<string>(this.Languages.keyset());
			s.sort();
			for (string key : s ) {
				LanguageOptions.add(new selectOption( this.Languages.get(key),key ) );
			} 
		}
		return LanguageOptions ;
	} private set; }
    public integer responseStatus { get { return response.getValue('responseStatus').num ; } } 
    public string responseDetails { get { return response.getValue('responseDetails').str; } } 
   	public string translatedText { get { return response.getValue('responseData').obj.getString('translatedText'); } } 
 
    private jsonobject response;
    public integer debug { get; set; } { debug = 1; } 
	private string uri = 'http://ajax.googleapis.com/ajax/services/language/translate';
	// use: http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=hello%20world&langpair=en%7Cit
	
	GoogleService service = new GoogleService('translate');
    
    public googledata getfeed( string url) {
    	service.getFeedMethod('GET',url,null, null);
    	if (debug > 1) system.debug( service.response.getBody() );
    	return parseResponse( service.response.getBody() ); 
    } 

    public googledata translate (string origin,string pair ) {
    	system.assert( origin.length() <= 500 , ' Google terms of service restrict to 500 chars');   
    	return this.getFeed( uri + '?v=1.0&q=' + EncodingUtil.urlEncode( origin, 'UTF-8') 
    	 + '&langpair='  + EncodingUtil.urlEncode( pair, 'UTF-8' ) );
    }
 
    private googledata parseResponse(string body ) { 
    	
		body = body.replaceAll('\\\\u0026#39;','\''); // are there others?
    	response = 	new jsonobject( body );
    	
    	if ( debug> 1) { 
    		system.debug( translatedText );
	  		system.debug( responseStatus );
	  		system.debug( responseDetails );
    	}
  		return new GoogleData( new xmldom('<entry><translatedText>'+
  			translatedText+'</translatedText><responseStatus>'+responseStatus+
  			'</responseStatus></entry>') );
  		
    }   
}