public with sharing class OverrideButtons {
 	
 	public OverrideButtons(ApexPages.StandardController controller) {
    }

	public Pagereference newContactButtonRedirect() {
		return redirect('/003/e?name_firstcon2=redirect&nooverride=1');
	}

    private static Pagereference redirect(String url) {
        return new PageReference(url);
    }
}