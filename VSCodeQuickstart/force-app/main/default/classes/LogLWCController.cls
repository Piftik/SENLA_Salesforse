public with sharing class LogLWCController {
    @AuraEnabled(cacheable=false)
    public static LogLWC__c createLogLWC(String objectType, String actionType, 
                                         String description, String errorMessage){
        try {
            LogLWCManager.LogLWCWrapper wrapper = new LogLWCManager.LogLWCWrapper();
            wrapper.objectType = objectType;
            wrapper.actionType = actionType;
            wrapper.description = description;
            wrapper.isSuccessful = String.isEmpty(errorMessage) ? true : false;
            wrapper.errorMessage = errorMessage;    

            return LogLWCManager.createLogLWC(wrapper, true);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<LogLWC__c> getLogsLWC(String fields){
        try {
            return LogLWCManager.getLogsLWC(fields);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
