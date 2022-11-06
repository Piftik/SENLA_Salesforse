@IsTest
public class TestDataFactory {

    static final Id DEFAULT_CONTACT_TYPE = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Broker').getRecordTypeId();
    static final Id DEFAULT_DEAL_TYPE = Schema.SObjectType.Deal__c.getRecordTypeInfosByName().get('Sale').getRecordTypeId();
    static final Id LEASE_DEAL_TYPE = Schema.SObjectType.Deal__c.getRecordTypeInfosByName().get('Lease').getRecordTypeId();
    static final Id DEFAULT_PROPERTY_TYPE = Schema.SObjectType.Property__c.getRecordTypeInfosByName().get('Industrial').getRecordTypeId();

    static final String DEFAULT_DEAL_STATUS = 'Open';
    static final String DEFAULT_PHONE = '+375494847464';
    static final String DEFAULT_EMAIL = 'test@mailtest.test';
    static Integer recordCounter = 0;



    public static Contact createContact(String firstName, String lastName, String phone, String email, Id recordTypeId) {
        Contact contact = new Contact(
                                    FirstName = firstName, 
                                    LastName = lastName, 
                                    Phone = String.isBlank(phone) ? DEFAULT_PHONE : phone, 
                                    Email = String.isBlank(email) ? DEFAULT_EMAIL + recordCounter++ : email, 
                                    RecordTypeId = String.isBlank(recordTypeId) ? DEFAULT_CONTACT_TYPE : recordTypeId 
                                    );

        insert contact;
        return contact;
    }

    public static List<Contact> createContacts(Integer count, String recordTypeId) {
        List<Contact> contacts = new List<Contact>(count);
        for (Integer i = 0; i < count; i++) {
            contacts[i] = new Contact(
                                    FirstName = 'test', 
                                    LastName = 'contact' + recordCounter, 
                                    Phone = DEFAULT_PHONE,
                                    Email = DEFAULT_EMAIL + recordCounter++,
                                    RecordTypeId = String.isBlank(recordTypeId) ? DEFAULT_CONTACT_TYPE : recordTypeId 
                                    );
        }

        insert contacts;
        return contacts;
    }    
    
    public static Deal__c createDeal(Contact salesman, Contact buyer, Property_NEW__c property, String status,
                                        String recordTypeId, String leaseStart, String leaseEnd) {
        Deal__c deal = new Deal__c(
                                Salesman__c = salesman.Id, 
                                Buyer__c = buyer.Id, 
                                Property_for_sale__c = property.Id,
                                Status__c = String.isBlank(status) ? DEFAULT_DEAL_STATUS : status, 
                                RecordTypeId = String.isBlank(recordTypeId) ? DEFAULT_DEAL_TYPE : recordTypeId
                                );
        if (deal.RecordTypeId == LEASE_DEAL_TYPE) {
            deal.Rental_start_date__c = Date.valueOf(leaseStart);
            deal.Rental_end_date__c = Date.valueOf(leaseEnd);
        }

        insert deal;
        return deal;
    }

    public static List<Deal__c> createDeals(Integer count, Contact salesman, Contact buyer, Property_NEW__c property, String status,
                                                String recordTypeId, String leaseStart, String leaseEnd) {
        List<Deal__c> deals = new List<Deal__c>(count);
        for (Integer i = 0; i < count; i++) {
            deals[i] = new Deal__c(
                                Salesman__c = salesman.Id, 
                                Buyer__c = buyer.Id, 
                                Property_for_sale__c = property.Id, 
                                Status__c = String.isBlank(status) ? DEFAULT_DEAL_STATUS : status,  
                                RecordTypeId = String.isBlank(recordTypeId) ? DEFAULT_DEAL_TYPE : recordTypeId
                                );
            if (deals[i].RecordTypeId == LEASE_DEAL_TYPE) {
                deals[i].Rental_start_date__c = Date.valueOf(leaseStart);
                deals[i].Rental_end_date__c = Date.valueOf(leaseEnd);
            }
        }

        insert deals;
        return deals;
    }

    public static Property_NEW__c createProperty(Contact propertyOwner, Decimal sellingPrice, Decimal rentalPrice,
                                        String country, String city, String address, String recordTypeId) {
        Property_NEW__c p = new Property_NEW__c(
                                    Property_Owner__c = propertyOwner.Id, 
                                    Selling_price__c = sellingPrice, 
                                    Rental_price_per_month__c = rentalPrice, 
                                    Country__c = country,
                                    City__c = city,
                                    Address__c = address,
                                    RecordTypeId = String.isBlank(recordTypeId) ? DEFAULT_PROPERTY_TYPE : recordTypeId
                                    );

        insert p;
        return p;
    }

   
   
  
}