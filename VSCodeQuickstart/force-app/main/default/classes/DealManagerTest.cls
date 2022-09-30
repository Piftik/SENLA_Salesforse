@isTest
public class DealManagerTest {    
    
        @isTest static void createDealTest() {
            DealManager.DealWrapper testWrapper = new DealWrapper();
            testWrapper.buyer = 'testBuyer';
            testWrapper.salesman = 'testSalesman';
            testWrapper.sellingProperty = 550.0;
            testWrapper.finishLease = 01.01.2022;     
           
            DealManager.createDeal(testWrapper, true);    
        }       
       
        @isTest static void getDealsByIdTest(){
    
            Id testId = '000001';
            List<Deal__c> deals = DealManager.getDealById(testId, 'testName');
        }
    
        @isTest static void getDealsByIdsTest(){
    
            List<Id> testIds = new List<Id>();
    
            testIds.add('000002');
            testIds.add('000003');
            testIds.add('000004');
    
            List<Deal__c> deals = DealManager.getDealsByIds(testIds, 'testName');
        }
    
    
}