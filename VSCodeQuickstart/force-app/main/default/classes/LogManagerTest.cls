@isTest
public class LogManagerTest {
    @isTest static void createLogTest() {
        LogManager.LogWrapper testWrapper = new LogWrapper();
        testWrapper.message = 'testMessage';
        testWrapper.logType = 'testLogType';        

        LogManager.createLog(testWrapper, true);

    }
   
   
    @isTest static void getLogByIdTest(){

        Id testId = '000001';
        List<Log__c> logs = LogManager.getLogByIdTest(testId, 'testName');
    }

    @isTest static void getLogsByIdsTest(){

        List<Id> testIds = new List<Id>();

        testIds.add('000002');
        testIds.add('000003');
        testIds.add('000004');

        List<Log__c> logs = LogManager.getLogsByIds(testIds, 'testName');
    }



    @isTest static void getLogsBylogTypesTest(){
       
        List<Log__c> logs = LogManager.getLogsBylogTypes('testlogType');

    }
}