public with sharing class ContactManager {
    
        public static String fields = 
        'Id, Name, Phone, HomePhone, Email, Total_Property_Price__c, Broker__c';
        
 
 
        public class ContactWrapper {
         public String firstName {get; set;}
         public String lastName {get; set;}
         public String phone {get; set;}
         public String homePhone {get; set;}
         public String email  {get; set;}
         public Date birthdate  {get; set;}
         public Double brokerPercentDeal {get; set;}
                 
     }
 
     public static Contact createContact(ContactWrapper wrapper, Boolean serialize) {
         Contact contact = new Contact();
         contact.FirstName = wrapper.firstName;
         contact.LastName = wrapper.lastName;
         contact.Phone = wrapper.phone;
         contact.HomePhone = wrapper.homePhone;
         contact.Email = wrapper.email;
         contact.Birthdate = wrapper.birthdate;
         contact.Broker__c = wrapper.brokerPercentDeal;
 
 
  
         if (serialize) insert contact;
  
         return contact;
     }
  
  
 
     public static List<Contact> getContactsByIds(List<Id> ids, String fields){
 
         String query = 'select ' + fields + ' from Contact where Id in :ids';
         List<Contact> contacts = Database.query(query);
         return contacts;
     } 
     
     public static Contact getContactById(Id contactId, String fields){
 
         String query = 'select ' + fields + ' from Contact where Id=:contactId';
         Contact contact = Database.query(query);
         return contact;
     }
     
     public static List<Contact> getContactsByEmail(String email){
 
         if (email == null) return new List<Contact>();
         
         String query = 'select ' + fields + ' from Contact where Email=:email';
         List<Contact> contacts = Database.query(query);
         return contacts;
     } 

     public static List<Contact> getContactsByBirthdater(String birthdate){
 
        if (birthdate == Date.today()) return new List<Contact>();
        
        String query = 'select ' + fields + ' from Contact where Birthdate=:birthdate';
        List<Contact> contacts = Database.query(query);
        return contacts;   
        // идея в том чтоб получить список контактов у кого сегодня день рождения, для выдачи разных плюшек(овнеру скидки, брокеру премия и т.д.)

     
    
}
}