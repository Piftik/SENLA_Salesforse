public with sharing class PropertyManager {
    public class PropertyWrapper {
        public String name {get; set;}
        public String address {get; set;}
        public Double monthlyRentalPrice {get; set;}
        public Double costSale {get; set;}
        
    }

    public static Property__c createProperty(PropertyWrapper wrapper, Boolean serialize) {
        Property__c property = new Property__c();
        property.Name = wrapper.name;
        property.Address__c = wrapper.address;
        property.Monthly_Rental_Price__c = wrappermonthlyRentalPrice;
        property.Cost_Sale__c = wrapper.costSale;

 
        if (serialize) insert property;
 
        return property;
    }
 
 

    public static List<Property__c> getPropertiesByIds(List<Id> ids, String fields){

        String query = 'select ' + fields + ' from Property__c where Id in :ids';
        List<Property__c> properties = Database.query(query);
        return properties;
    } 
    
    public static Property__c getPropertyById(Id propertyId, String fields){

        String query = 'select ' + fields + ' from Property__c where Id=:propertyId';
        Property__c property = Database.query(query);
        return property;
    }
    
    public static List<Property__c> getPropertiesByAdress(String address){

        String query = 'select ' + fields + ' from Property__c where Adress__c=:address';
        List<Property__c> properties = Database.query(query);
        return properties;
    } 

    //Еще была идея сгруппировать проперти по адресам(страны,штаты)
}
