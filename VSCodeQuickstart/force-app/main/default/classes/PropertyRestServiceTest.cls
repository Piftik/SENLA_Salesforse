@IsTest
private class PropertyRestService_Test {

    @testSetup
    static void setup()
    {
        Contact seller = TestDataFactory.createContact('seller', '+345679313231');
        Contact customer = TestDataFactory.createContact('customer', '+3751234565432');
        Location_Wrapper__c location = TestDataFactory.createLocationWrapper('testAddress');
        Property_New__c property = TestDataFactory.createProperty(seller, 10000, 30, location);
        TestDataFactory.createDealLeaseWithDate(seller, customer, property.Id, Date.valueOf('2022-09-01'), Date.valueOf('2022-10-01'));
    }

    @isTest static void getPropertyByOwnerTest() {
        Contact owner = [SELECT Id, LastName FROM Contact WHERE Email = 'test@mail.ru' LIMIT 1];
        RestRequest request = new RestRequest();
        request.requestUri = 'https://senla-cd-dev-ed.my.salesforce.com/services/data/v55.0/sobjects/propery/v1/by_owner?owner=' + owner.Id;
        request.httpMethod = 'GET';
        RestContext.request = request;

        String result = PropertyRESTService.getProperty();
        System.assert(result != null);
    }

    @isTest static void getPropertyReportTest() {
        Property_New__c prop = [SELECT Id FROM Property_New__c WHERE Price_Sold__c = 10000 LIMIT 1];
        System.debug(prop);
        RestRequest request = new RestRequest();
        request.requestUri = 'https://senla-cd-dev-ed.my.salesforce.com/services/data/v55.0/sobjects/propery/v1/report/' + prop.Id +'?startDate=2022-09-01&endDate=2022-10-01&dealType=Lease';
        request.httpMethod = 'GET';
        RestContext.request = request;

        String result = PropertyRESTService.getProperty();
        System.debug(result);
        System.assert(result != null);
    }

    @IsTest static void createPropertyTest() {
        Contact owner = [SELECT Id FROM Contact WHERE Email = 'test@mail.ru' LIMIT 1];
        PropertyManager.LocationWrapper location = new PropertyManager.LocationWrapper('asd', 'eqw', 'asd','zxc', 'ewqasd');
        PropertyManager.PropertyWrapper wrapper = new PropertyManager.PropertyWrapper(1000, 10, owner, location);

        RestRequest request = new RestRequest();
        request.requestUri = 'https://senla-cd-dev-ed.my.salesforce.com/services/data/v55.0/sobjects/propery/v1/add';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(JSON.serialize(wrapper));
        RestContext.request = request;

        Property_New__c result = PropertyRESTService.createNewProperty();
        System.assert(result != null);
        System.assert([SELECT COUNT() FROM Property_New__c WHERE Price_Sold__c = 1000] > 0);
    }

    @isTest static void upsertPropertyOwnerTest() {
        Property_New__c prop = [SELECT Id FROM Property_New__c LIMIT 1];
        SerializationWrappers.UpdatePropertyOwnerPUTWrapper wrap = new SerializationWrappers.UpdatePropertyOwnerPUTWrapper();
        wrap.propertyId = prop.Id;
        wrap.newOwner = new SerializationWrappers.Client();
        wrap.newOwner.firstName = 'testName';
        wrap.newOwner.email = 'newEmail@mail.ru';

        RestRequest request = new RestRequest();
        request.requestUri = 'https://senla-cd-dev-ed.my.salesforce.com/services/data/v55.0/sobjects/propery/v1';
        request.httpMethod = 'PUT';
        request.requestBody = Blob.valueOf(JSON.serialize(wrap));
        RestContext.request = request;

        String result = PropertyRESTService.upsertPropertyOwner();

        System.assert(result != null);
        System.assert([SELECT COUNT() FROM Property_New__c WHERE Owner__r.Email = 'newEmail@mail.ru'] > 0);
    }
}