public with sharing class PropertyController {
    private static final Integer DEFAULT_PAGE_SIZE = 8;
    @AuraEnabled(cacheable=true)
    public static List<Property_New__c> getPropertyList() {
        
        return [
            SELECT Id, Name, Address__c, Property_Owner__r.Name, Cost_Sale__c, Picture__c
            FROM Property_New__c
            WHERE Picture__c != NULL
            ];
    }

    @AuraEnabled(cacheable=true scope='global')
    public static PagedResult getPagedPropertyList(
       
        Integer pageSize,
        Integer pageNumber
    ) {
        // Normalize inputs
      
        Integer safePageSize = (pageSize == null
            ? DEFAULT_PAGE_SIZE
            : pageSize);
        Integer safePageNumber = (pageNumber == null ? 1 : pageNumber);

      
        Integer offset = (safePageNumber - 1) * safePageSize;

        PagedResult result = new PagedResult();
        result.pageSize = safePageSize;
        result.pageNumber = safePageNumber;
        result.totalItemCount = [
            SELECT COUNT()
            FROM Property_New__c
            WHERE Picture__c != NULL
                     
        ];
        result.records = [
            SELECT Id, Name, Address__c, Property_Owner__r.Name, Cost_Sale__c, Picture__c
            FROM Property_New__c
            WHERE Picture__c != NULL
            LIMIT :safePageSize
            OFFSET :offset
        ];
        return result;
    }
}
