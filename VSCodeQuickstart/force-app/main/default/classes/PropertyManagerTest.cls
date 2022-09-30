@isTest
public  class PropertyManagerTest {
    
    @isTest static void createPropertyTest() {
       
        PropertyManager.PropertyWrapper testWrapper = new PropertyWrapper();
        testWrapper.name = 'testName';
        testWrapper.address = 'testAddress';
        testWrapper.monthlyRentalPrice = 100;
        testWrapper.costSale = 100000;        


        return PropertyManager.createProperty(testWrapper, true);
    }
   
   
    @isTest static void getPropertyByIdTest(){

        Id testId = '000001';
        List<Property__c> properties = PropertyManager.getPropertyById(testId, 'testName');
    }

    @isTest static void getPropertiesByIdsTest(){

        List<Id> testIds = new List<Id>();

        testIds.add('000002');
        testIds.add('000003');
        testIds.add('000004');

        List<Property__c> properties = PropertyManager.getPropertiesByIds(testIds, 'testName');
    }

    @isTest static void getPropertiesByAdressTest(){
       
        List<Property__c> propertiess = PropertyManager.getPropertiesByAdress('testAddress');

    }
}