<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Copy_Email_to_Email_Unqiue</fullName>
        <description>Copy Email to Email_Unqiue</description>
        <field>Email_Unique__c</field>
        <formula>Email</formula>
        <name>Copy Email to Email_Unqiue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Copy Email to Email_Unqiue</fullName>
        <actions>
            <name>Copy_Email_to_Email_Unqiue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Copy Email to Email_Unqiue</description>
        <formula>Email  &lt;&gt;  Email_Unique__c</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
