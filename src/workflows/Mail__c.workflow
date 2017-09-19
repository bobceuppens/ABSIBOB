<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>MailSend</fullName>
        <description>MailSend</description>
        <protected>false</protected>
        <recipients>
            <recipient>bob@absi.be</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/MailSendFromBodyHTML</template>
    </alerts>
    <rules>
        <fullName>MailSend</fullName>
        <actions>
            <name>MailSend</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
