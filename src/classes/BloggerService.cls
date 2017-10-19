public class BloggerService {
    GoogleService service = new GoogleService('blogger');
    public void setAuthSubToken(string t) { service.AuthSubToken = t;   }
    
    public GoogleData getFeed(string url) {  
        return service.getFeed(url); 
    } 
    
    public void makePostRequest( string editUrl, string body) {
        service.makePostRequest( editUrl, body);
    }

    public xmldom.element getBlogTitle( string t) { 
        GoogleData feed = service.getFeed( defaultFeed ); 
        for (xmldom.element ee: feed.entries ) { 
            if ( ee.getValue('title').startsWith ( t ) ) {  
                return ee; 
            }        
        } return null;
    }
    
    public xmldom.element makeBlogElement( string title, string authorname, string email) {
        
        xmldom.element atom = GoogleData.makeElement('entry','');
        GoogleData.addNameSpace(atom);
        GoogleData.addAPINameSpace(atom,'xmlns:app','http://purl.org/atom/app#');
        
        atom.appendChild( Googledata.createTextNode ( 'title',title) );
        xmldom.element author = GoogleData.makeElement('author','');
        author.appendChild( Googledata.createTextNode ( 'name',authorname) );
        author.appendChild( Googledata.createTextNode ( 'email',email) );
        atom.appendChild( author);
        return atom;
    }
    
    public xmldom.element setContent (xmldom.element atom, string xhtml ) {
        xmldom content = new xmldom(
            '<content type="xhtml"><div xmlns="http://www.w3.org/1999/xhtml">' +
            xhtml + '</div></content>');
        atom.appendChild( content.getElementByTagName('content') );
        return atom;
    }
    
    public void insertEntry ( xmldom.element blog, xmldom.element atom ) {
        service.makePostRequest( 
            GoogleData.getRelLink(blog, BloggerService.postUrl) ,
            atom.toXmlString() ); 
    }
    
    public void setDraft(  xmldom.element atom ) {
        xmldom.element control = new xmldom.element('app:control');
        control.appendChild( 
         GoogleData.makeElement('app:draft','yes'));
        atom.appendChild( control );    
    }
    
    
    /* 
    Creating comments
    
    To post a comment, create an Atom <entry> element like the following:
    
      <entry xmlns='http://www.w3.org/2005/Atom'>
        <title type="text">This is my first comment</title>
        <content type="html">This is my first comment</content>
        <author>
          <name>Blog Author name</name>
        </author>
      </entry>
    
    to POST http://www.blogger.com/feeds/blogID/postID/comments/default
    
    */

    /* 
    Deleting comments
    
    To delete a comment, send a DELETE request to the comment's edit URL. This URL is highlighted in the comments feed above.
    */
        
    /* 
        Retrieving posts using query parameters
    
    The Blogger Data API lets you request a set of entries that match specified criteria, such as requesting blog posts created or updated in a given date range.
    
    For example, to send a date-range query, add the updated-min and updated-max 
    parameters to the request URL. To get all the blog entries updated from 
    March 16, 2008 to 
    March 24, 2008, send an HTTP request to the blog's feed URL:
        The Blogger Data API supports the following query parameters:
    
    alt
        The type of feed to return, such as atom (the default) or rss.
    /category
        Specifies categories (also known as labels) to filter the feed results. 
        For example, http://www.blogger.com/feeds/blogID/posts/default/-/Fritz/Laurie 
        returns entries with both the labels Fritz and Laurie.
    max-results
        The maximum number of entries to return.
    orderby
        The order in which to return entries, such as lastmodified (the default), 
        starttime, or updated.
    published-min, published-max
        The bounds on entry publication dates.
    start-index
        The 1-based index of the first result to be retrieved (for paging).
    updated-min, updated-max
        The bounds on entry update dates. These query parameters are ignored 
        unless the orderby parameter is set to updated. 
     */
    
    /* *******************************
     * 
     * test methods below here 
     */
    public static final string defaultFeed = 'https://www.blogger.com/feeds/default/blogs';
    public static final string postUrl =   'https://schemas.google.com/g/2005#post';

     
    //bloggerServieTest
    static final string sessionAuthToken = 'CJ3pqczuBBD5wJOG______8B';
   
}