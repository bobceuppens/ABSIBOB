<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>BlueConic_Lead_Name</fullName>
        <field>LastName</field>
        <formula>&apos;BlueConic Lead&apos;</formula>
        <name>BlueConic Lead Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>BlueConic Lead Name</fullName>
        <actions>
            <name>BlueConic_Lead_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.LastName</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Company</field>
            <operation>contains</operation>
            <value>BC Lead</value>
        </criteriaItems>
        <description>Exception for BlueConic Leads</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
