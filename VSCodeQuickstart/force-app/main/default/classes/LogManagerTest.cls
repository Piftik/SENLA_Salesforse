@isTest
public class LogManagerTest {
    @isTest static void createLogTest() {
        LogManager.LogWrapper testWrapper = new LogWrapper();
        testWrapper.name = 'testName';
        testWrapper.message = 'testMessage';
        testWrapper.type = 'testType';        

        return LogManager.createLog(testWrapper, true);

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

    @isTest static void getLogsByMessageTest(){
       
        List<Log__c> logs = LogManager.getLogsByMessage('testMessage');

    }

    @isTest static void ggetLogsByTypeTest(){
       
        List<Log__c> logs = LogManager.getLogsByType('testType');

    }
}