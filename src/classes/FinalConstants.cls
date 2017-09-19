/**
 *	Creation Date : 20090608 
 *	Description : Common final consts used by Classes / Triggers
 *	Auhor : ABSI / MC 
 */

public class FinalConstants {
	/**
	 * Important : 
	 * These Ids will not be the same in the Live Org, please change it after the deployment. 
	 * The priceBookEntries cannot be find on salesforce, query the PriceBookEntry for the product MP & CPX
	 */
	// Opportunity Record Type : CPC Standard 
	
	//Developers ... do not forget the 18 digit Id version PLEASE !!!!!!!!
	public final static String opptyRecordTypeCPX 			= '012R00000000JHBIA2';	 
	
	public final static String opptyRecordTypeMP 			= '012R00000000JIYIA2';
	
	public final static String opptyRecordTypeCPC 			= '012R00000000JDJIA2';
	
	public final static String opptyRecordTypeCPM 			= '012R00000000JDOIA2';
	
	// Opportunity Record Type : CPC goedgekeurd
	public final static String opptyRecordTypeCPCgek		= '012R00000000JKeIAM' ;
	
	public final static String opptyRecordTypeMPgek			= '012R00000000JjtIAE' ;
	
	public final static String opptyRecordTypeCPMgek		= '012R00000000JPFIA2' ;
	
	public final static String opptyRecordTypeCPXgek		= '012R00000000JjoIAE' ;
	
	
	// Opportunity Stage Name = "Closed Won"
	public final static String closedWon 				= 'Gesloten/gewonnen' ;  
	
	// CPX Product Product Entry Id  

	public final static String cpxPriceBookEntry 		= '01uR0000001JU7gIAG';
	public final static String mpPriceBookEntry 		= '01uR0000001JU7WIAW';

	// Different Status
	
	public final static String cancelled 				= 'Cancelled' ; 
	public final static String onHold					= 'On Hold' ; 
	public final static String open						= 'Open' ; 
	public final static String sentToInvoice			= 'Sent to Invoice' ; 
	public final static String invoiced					= 'Invoiced' ; 
	public final static String toInvoice				= 'To Invoice' ;  
	
}