public with sharing class PropertyManager {
    public class PropertyWrapper {
        public String name {get; set;}
        public String address {get; set;}
        public Double monthlyRentalPrice {get; set;}
        public Double costSale {get; set;}
        
    }

    public static Property_New__c createProperty(PropertyWrapper wrapper, Boolean serialize) {
        Property_New__c property = new Property_New__c();
        property.Name = wrapper.name;
        property.Address__c = wrapper.address;
        property.Monthly_Rental_Price__c = wrapper.monthlyRentalPrice;
        property.Cost_Sale__c = wrapper.costSale;

 
        if (serialize) insert property;
 
        return property;
    }
 
 

    public static List<Property_New__c> getPropertiesByIds(List<Id> ids, String fields){

        String query = 'select ' + fields + ' from Property_New__c where Id in :ids';
        List<Property_New__c> properties = Database.query(query);
        return properties;
    } 
    
    public static Property_New__c getPropertyById(Id propertyId, String fields){

        String query = 'select ' + fields + ' from Property_New__c where Id=:propertyId';
        Property_New__c property = Database.query(query);
        return property;
    }
    
    public static List<Property_New__c> getPropertiesByAdress(String address){

        String query = 'select ' + fields + ' from Property_New__c where Adress__c=:address';
        List<Property_New__c> properties = Database.query(query);
        return properties;
    } 

}
