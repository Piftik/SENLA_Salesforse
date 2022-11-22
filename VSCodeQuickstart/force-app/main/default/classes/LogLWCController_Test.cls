@isTest
public with sharing class LogLWCController_Test {
    static final String FIELDS = 'ObjectType__c, ActionType__c, Description__c, IsSuccessful__c, ErrorMessage__c';

    @testSetup 
    static void setup() 
    {      
        LogLWC__c log1 = TestDataFactory.createLogLWC('Property_New__c', 'Insert','create Property',true,'');
        LogLWC__c log2 = TestDataFactory.createLogLWC('Deal__c', 'Update','create Deal',false,'Error');
    }

    @isTest static void testCreateLogLWC(){
        LogLWC__c logLWC = LogLWCController.createLogLWC('Property_New__c', 'Insert', 'Test', '');
        System.assertEquals(true, logLWC.IsSuccessful__c);
    }

    @isTest static void testGetLogsLWC(){
        List<LogLWC__c> logsLWCListTest = [SELECT Id FROM LogLWC__c];
        List<LogLWC__c> LogsLWCList = LogLWCController.getLogsLWC(FIELDS);
        System.assertEquals(logsLWCListTest.size(), LogsLWCList.size());
    }
}