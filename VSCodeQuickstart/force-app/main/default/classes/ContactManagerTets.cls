@isTest
public class ContactManagerTest {
    
    @isTest static void createContactTest() {
        ContactManager.ContactWrapper testWrapper = new ContactWrapper();
        testWrapper.firstName = 'testFirstName';
        testWrapper.lastName  = 'testLastName';
        testWrapper.phone = '123-31234567';
        testWrapper.email = 'testEmail@gmail.com';
        testWrapper.homePhone = '123-1234';
        testWrapper.brokerPercentDeal  = 10.4;

    

        return ContactManager.createContact(testWrapper, true);
    }   
   
    @isTest static void getContactByIdTest(){
        
        Id testId = '000001';
        List<Contact> cts = ContactManager.getContactById(testId, 'testName');
    }

    @isTest static void getContactsByIdsTest(){

        List<Id> testIds = new List<Id>();

        testIds.add('000002');
        testIds.add('000003');
        testIds.add('000004');

        List<Contact> cts = ContactManager.getContactById(testIds, 'testName');
    }

    @isTest static void getContactsByEmailTest(){
       
        List<Contact> cts = ContactManager.getContactsByEmail('testEmail@gmail.com');
    }

   
}