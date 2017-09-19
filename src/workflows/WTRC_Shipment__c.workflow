<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Parcel_Delivery_Copy_Name_to_Barcode</fullName>
        <field>ID__c</field>
        <formula>Name</formula>
        <name>Parcel Delivery Copy Name to Barcode</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Copy Barcode</fullName>
        <actions>
            <name>Parcel_Delivery_Copy_Name_to_Barcode</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
