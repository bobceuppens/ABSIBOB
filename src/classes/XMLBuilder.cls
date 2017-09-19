/**
 * Creation Date: 	20110118
 * Description: 	XMLBuilder
 * 
 * Author: 	ABSI - Bob Ceuppens
 */	
 
public with sharing class XMLBuilder {
	
	public static String getGenericXML(sObject myObject, Set <String> fieldsToExclude) {
   		
   		Map<String, String> resultMap = XMLBuilder.getMapFromsObject(myObject,fieldsToExclude);
		
		XmlStreamWriter w = new XmlStreamWriter();
		w.writeStartElement(null,'SFDC_DATA',null);
		w.writeStartElement(null,resultMap.get('SOBJECTTYPE'),null);
		for(String fieldName:resultMap.keySet()){
			w.writeStartElement(null,fieldName.toUpperCase(),null);
			w.writeCharacters(resultMap.get(fieldName));
			w.writeEndElement();
		}
		w.writeEndElement();//endNode
		w.writeEndElement();//endGraph

		w.writeEndDocument();

		String xmlOutput=w.getXmlString();
		w.close();
		
		System.debug('################# ABSILOG - getXML xmlOutput ' + xmlOutput + '##########');

		return xmlOutput;		
	}
	
	public static Map<String, String> getMapFromsObject(sObject myObject, Set <String> fieldsToExclude) {
		
    	Schema.SObjectType sObjectType = myObject.getSObjectType();
    	String sObjectTypeAsString = String.valueOf(sObjectType);
    	
    	System.debug('################# ABSILOG : sObjectTypeAsString ' + sObjectTypeAsString + ' ##########');
    	
    	Map<String, Schema.SObjectField> sObjectFieldMap = sObjectType.getDescribe().fields.getMap();
    	 	
    	Map<String, String> resultMap = new Map<String,String>();
    	
    	resultMap.put('SOBJECTTYPE', sObjectTypeAsString);
    	
		for (String fieldName : sObjectFieldMap.keySet()) {
			System.debug('################# ABSILOG : fieldName ' + fieldName + ' ##########');
			if (!fieldsToExclude.contains(fieldName)) { 
			    if (String.valueOf(myObject.get(fieldName)) == null) {
			    	resultMap.put(fieldName.toUpperCase(), '');
			    }
			    else {
			    	resultMap.put(fieldName.toUpperCase(), String.valueOf(myObject.get(fieldName)));		    	
			    }
			}
			else {
				System.debug('################# ABSILOG : fieldName ' + fieldName + ' in fieldsToExclude' + ' ##########');
			}
		}
		
    	System.debug('################# ABSILOG : resultMap ' + resultMap + ' ##########');
    	
    	return resultMap;		
	}
	
	public static String getWTRCXML(sObject myObject, Set <String> fieldsToExclude) {
	
   		Map<String, String> resultMap = XMLBuilder.getMapFromsObject(myObject,fieldsToExclude);
		
		XmlStreamWriter w = new XmlStreamWriter();

		w.writeStartElement(null,'MESSAGE',null);
		
		w.writeStartElement(null,'PARAMETERS',null);

		w.writeStartElement(null,'SERVICE',null);
		w.writeCharacters(resultMap.get('SERVICE__C'));
		w.writeEndElement();
		
		w.writeStartElement(null,'USERNAME',null);
		w.writeCharacters(resultMap.get('USERNAME__C'));
		w.writeEndElement();

		w.writeStartElement(null,'MASTER',null);
		w.writeCharacters(resultMap.get('MASTER__C'));
		w.writeEndElement();
				
		w.writeEndElement(); // END PARAMETERS
		
		w.writeStartElement(null,'SFDC_DATA',null);
		w.writeStartElement(null,resultMap.get('SOBJECTTYPE'),null);
		for(String fieldName:resultMap.keySet()){
			w.writeStartElement(null,fieldName.toUpperCase(),null);
			w.writeCharacters(resultMap.get(fieldName));
			w.writeEndElement();
		}
		w.writeEndElement();// END sObjectTypeAsString
		
		w.writeEndElement();//END SFDC_DATA

		w.writeEndDocument();// END MESSAGE

		String xmlOutput=w.getXmlString();
		w.close();
				
		return xmlOutput;
	}
	
    public static String getXML(List<sObject> myObjects, Set <String> fieldsToExclude) {

		String myXML = '';
    	for (sObject myObject : myObjects) {
    		myXML = myXML + XMLBuilder.getGenericXML(myObject,fieldsToExclude);
    	}
		return myXML;
    }

    public static String getXML(sObject myObject, Set <String> fieldsToExclude) {

		String myXML = '';
   		myXML = myXML + XMLBuilder.getGenericXML(myObject,fieldsToExclude);
		return myXML;
    }

    /*
 	private static Map<String, Map<String,Schema.Sobjectfield>> sObjectFieldCache =new Map<String, Map<String,Schema.Sobjectfield>>();
    
    public static Map<String,Schema.Sobjectfield> getSObjectFields(Schema.SObjectType sObjectType) {
    	String sObjectTypeAsString = String.valueOf(sObjectType);
    	// If it's not already in the cache, add the sObject's field map to the cache
    	if (!sObjectFieldCache.containsKey(sObjectTypeAsString)) {
    	   sObjectFieldCache.put(sObjectTypeAsString, sObjectType.getDescribe().fields.getMap());
    	}
    	return sObjectFieldCache.get(sObjectTypeAsString);
    }
    */
   
}