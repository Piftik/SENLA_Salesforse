@isTest
public with sharing class LogLWCManager_Test {
    static final String FIELDS = 'ObjectType__c, ActionType__c, Description__c, IsSuccessful__c, ErrorMessage__c';

    @testSetup 
    static void setup() 
    {      
        LogLWC__c logLWC1 = TestDataFactory.createLogLWC('Property_New__c', 'Insert','create Property',true,'');
        LogLWC__c logLWC2 = TestDataFactory.createLogLWC('Deal__c', 'Update','create Deal',false,'Error');
    }
    @isTest static void testCreateLogLWC(){
        LogLWCManager.LogLWCWrapper wrapper = new LogLWCManager.LogLWCWrapper();
        wrapper.objectType = 'Property_New__c';
        wrapper.actionType = 'Insert';
        wrapper.description = 'description';
        wrapper.isSuccessful = true;
        wrapper.errorMessage = '';

        LogLWC__c logLWC = LogLWCManager.createLogLWC(wrapper, false);
        System.assertEquals(true, logLWC.IsSuccessful__c);
    }

    @isTest static void testGetLogsLWCByObjectType(){
        List<LogLWC__c> LogsLWCList = LogLWCManager.getLogsLWCByObjectType(FIELDS, 'Deal__c');
        System.assertEquals(1, LogsLWCList.size());
    }

    @isTest static void testGetLogsLWC(){
        List<LogLWC__c> logsLWCListTest = [SELECT Id FROM LogLWC__c];
        List<LogLWC__c> LogsLWCList = LogLWCManager.getLogsLWC(FIELDS);
        System.assertEquals(logsLWCListTest.size(), LogsLWCList.size());
    }
}
