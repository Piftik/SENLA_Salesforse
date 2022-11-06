@isTest
public class PropertyOwnerControllerTest {
    static final Id PROP_OWNER_TYPE = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Property Owner').getRecordTypeId();
    static final Id INDUSTRIAL_PROPERTY_TYPE = Schema.SObjectType.Property__c.getRecordTypeInfosByName().get('Industrial').getRecordTypeId();
    static final Id OFFICE_PROPERTY_TYPE = Schema.SObjectType.Property__c.getRecordTypeInfosByName().get('Office').getRecordTypeId();
    static final Id SPACE_PROPERTY_TYPE = Schema.SObjectType.Property__c.getRecordTypeInfosByName().get('Space').getRecordTypeId();
    static final Id SALE_TYPE = Schema.SObjectType.Deal__c.getRecordTypeInfosByName().get('Sale').getRecordTypeId();

    @testSetup 
    static void setup() 
    {       
        Contact owner1 = TestDataFactory.createContact('Test Contact', 'Owner 1', '', 'test_prop1@setuped.con', PROP_OWNER_TYPE);
        Contact owner2 = TestDataFactory.createContact('Test Contact', 'Owner 2', '', 'test_prop2@setuped.con', PROP_OWNER_TYPE);

        Property__c prop1 = TestDataFactory.createProperty(owner1, 5000, 400, 'USA', 'NY', 'Prop address 1', INDUSTRIAL_PROPERTY_TYPE);
        Property__c prop2 = TestDataFactory.createProperty(owner1, 10000, 300, 'USA', 'NY', 'Prop address 2', INDUSTRIAL_PROPERTY_TYPE);
        Property__c prop3 = TestDataFactory.createProperty(owner1, 20000, 130, 'USA', 'NY', 'Prop address 3', INDUSTRIAL_PROPERTY_TYPE);
        Property__c prop4 = TestDataFactory.createProperty(owner1, 30000, 200, 'USA', 'NY', 'Prop address 4', OFFICE_PROPERTY_TYPE);
        Property__c prop5 = TestDataFactory.createProperty(owner1, 40000, 200, 'USA', 'NY', 'Prop address 5', OFFICE_PROPERTY_TYPE);
        Property__c prop6 = TestDataFactory.createProperty(owner1, 50000, 700, 'USA', 'NY', 'Prop address 6', OFFICE_PROPERTY_TYPE);
        Property__c prop7 = TestDataFactory.createProperty(owner1, 60000, 1200, 'USA', 'NY', 'Prop address 7', SPACE_PROPERTY_TYPE);
        Property__c prop8 = TestDataFactory.createProperty(owner1, 70000, 1200, 'USA', 'NY', 'Prop address 8', SPACE_PROPERTY_TYPE);

        Deal__c sale1 = TestDataFactory.createDeal(owner1, owner2, prop1, '', SALE_TYPE, '', '');
        Deal__c sale2 = TestDataFactory.createDeal(owner1, owner2, prop2, 'Closed Won', SALE_TYPE, '', '');
        Deal__c sale3 = TestDataFactory.createDeal(owner1, owner2, prop3, 'Closed Won', SALE_TYPE, '', '');
        Deal__c sale4 = TestDataFactory.createDeal(owner1, owner2, prop4, 'Closed Won', SALE_TYPE, '', '');
        Deal__c sale5 = TestDataFactory.createDeal(owner1, owner2, prop5, 'Closed Won', SALE_TYPE, '', '');
        Deal__c sale6 = TestDataFactory.createDeal(owner1, owner2, prop6, 'Closed Won', SALE_TYPE, '', '');
        Deal__c sale7 = TestDataFactory.createDeal(owner1, owner2, prop7, 'Closed Won', SALE_TYPE, '', '');
        Deal__c sale8 = TestDataFactory.createDeal(owner1, owner2, prop8, 'Closed Won', SALE_TYPE, '', '');
    }

    @isTest static void testGetGroupedRelatedDeals() {
        Contact propOwner = [SELECT Id, Name, Total_Property_Price__c FROM Contact WHERE LastName = 'Owner 1' LIMIT 1];
        ApexPages.currentPage().getParameters().put('lc', propOwner.id);
		ApexPages.StandardController stdCon = new ApexPages.StandardController(propOwner);
        PropertyOwnerController controller = new PropertyOwnerController(stdCon);

        List<PropertyOwnerController.DealTableWrapper> result = controller.getGroupedRelatedDeals();
        System.assert(result.size() == 3);
        System.assertEquals(35000, result[0].totalSum);
        System.assertEquals(2, result[0].wonDealsCount);
    }
}
