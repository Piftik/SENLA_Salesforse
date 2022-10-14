@RestResource(UrlMapping='/propery/v1/*')
global class PropertyRESTService {
    @HttpGet
    global static String getProperty() {
        String response;
        String path = RestContext.request.requestURI.substringAfterLast('v1/');
        if (path.contains('by_owner?owner=')) {
            response = getSerializedProperty(path.substringAfterLast('by_owner?owner='));
        }
        else if (path.contains('report/')) {
            response = getSerializedDeal(path.substringAfterLast('report/').substringBefore('?'),
                    path.substringAfterLast('startDate=').substringBefore('&'),
                    path.substringAfterLast('endDate=').substringBefore('&'),
                    path.substringAfterLast('dealType='));
        }
        else {
            response = 'Invalid path';
        }

        return response;
    }

    @HttpPost
    global static String createProperty() {
        PropertyManager.PropertyWrapper wrapper = (PropertyManager.PropertyWrapper)
                JSON.deserialize(RestContext.request.requestBody.toString(),
                        PropertyManager.PropertyWrapper.class);

        return JSON.serialize(TestDataFactory.createProperty(wrapper, true));
    }

    @HttpPut
    global static String changePropertyOwner() {
        RESTWrappers.changeOwnerWrapper changeOwner = (RESTWrappers.changeOwnerWrapper)
                                                                      JSON.deserialize(RestContext.request.requestBody.toString(),
                                                                      REST_Wrapers.changeOwnerWrapper.class);

        Id ownerID = [SELECT Owner__c FROM Property_New__c WHERE Id = :changeOwner.propertyId].Owner__c;
        Contact owner = [SELECT Id, FirstName, LastName, Email FROM Contact WHERE Id =:ownerID LIMIT 1];
        owner.Id = String.isNotEmpty(changeOwner.newOwner.sfId) ? changeOwner.newOwner.sfId : owner.Id;
        owner.FirstName = String.isNotEmpty(changeOwner.newOwner.firstName) ? changeOwner.newOwner.firstName : owner.FirstName;
        owner.LastName = String.isNotEmpty(changeOwner.newOwner.lastName) ? changeOwner.newOwner.lastName : owner.LastName;
        owner.Email = changeOwner.newOwner.email;
        upsert owner;
        return JSON.serialize(owner);
    }
    
    private static String getSerializedProperty(Id ownerId) {
        String fields = 'Id, Country__c, City__c, Address__c, Latitude__c, Longitude__c, Property_Owner__c,' +
                ' Rent_Price__c, Sold_Price__c, Owner__c';

        List<Property__c> properties = PropertyManager.getPropertiesByOwners(new List<Id>{ownerId}, fields);

        return JSON.serialize(properties, true);
    }

    private static String getSerializedDeal(String propId, String startRentString, String endRentString, String recTypeName) {
        String fields = 'Id, Date_Start_Rent__c, Date_End_Rent__c, RecordType.DeveloperName, ' +
                'Deal_Amount__c, Selling_Property__c, Customer__c, Seller__c, Status__c';

        Date startRent = Date.valueOf(startRentString);
        Date endRent = Date.valueOf(endRentString);
        List<Deal__c> deals = DealManager.getDealsByDateAndRecordType(propId, fields, recTypeName, startRent, endRent);

        SerializationWrapper.Response response = new SerializationWrapper.Response(startRent, endRent, deals);

        return JSON.serialize(response, true);
    }
}