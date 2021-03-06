<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <outboundMessages>
        <fullName>Oppt_Push</fullName>
        <apiVersion>40.0</apiVersion>
        <endpointUrl>http://80.65.128.7:8081/Demo/</endpointUrl>
        <fields>AccountId</fields>
        <fields>AdverteerderName__c</fields>
        <fields>Amount</fields>
        <fields>CampaignId</fields>
        <fields>CloseDate</fields>
        <fields>CreatedById</fields>
        <fields>CreatedDate</fields>
        <fields>CurrentGenerators__c</fields>
        <fields>DeliveryInstallationStatus__c</fields>
        <fields>Description</fields>
        <fields>ExpectedRevenue</fields>
        <fields>FiscalQuarter</fields>
        <fields>FiscalYear</fields>
        <fields>ForecastCategory</fields>
        <fields>HasOpportunityLineItem</fields>
        <fields>Id</fields>
        <fields>IsClosed</fields>
        <fields>IsDeleted</fields>
        <fields>IsPrivate</fields>
        <fields>IsWon</fields>
        <fields>LastActivityDate</fields>
        <fields>LastModifiedById</fields>
        <fields>LastModifiedDate</fields>
        <fields>LeadSource</fields>
        <fields>MainCompetitors__c</fields>
        <fields>Name</fields>
        <fields>NextStep</fields>
        <fields>OrderNumber__c</fields>
        <fields>OwnerId</fields>
        <fields>Pricebook2Id</fields>
        <fields>Probability</fields>
        <fields>StageName</fields>
        <fields>SystemModstamp</fields>
        <fields>TotalOpportunityQuantity</fields>
        <fields>TrackingNumber__c</fields>
        <fields>Type</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>bob@absi.be</integrationUser>
        <name>Oppt__Push</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>Delete shared Opps after original Opp was deleted</fullName>
        <active>false</active>
        <formula>AND( 	ISCHANGED(ConnectionReceivedId ), 	NOT(ISBLANK(PRIORVALUE(ConnectionReceivedId))), 	ISBLANK(ConnectionReceivedId) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity_Push</fullName>
        <actions>
            <name>Oppt_Push</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Probability</field>
            <operation>greaterThan</operation>
            <value>50</value>
        </criteriaItems>
        <description>Demo OM</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
