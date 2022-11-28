public inherited sharing class LogLWCManager {

    public class LogLWCWrapper{
        public String objectType {get; set;}
        public String actionType {get; set;}
        public String description {get; set;}
        public Boolean isSuccessful {get; set;}
        public String errorMessage {get; set;}
    }

    public static List<LogLWC__c> getLogsLWC(string fields) {
        return Database.query('SELECT ' + fields + ' FROM LogLWC__c');
    }

    public static List<LogLWC__c> getLogsLWCByObjectType(string fields, string objectType) {
        return Database.query('SELECT ' + fields + ' FROM LogLWC__c WHERE ObjectType__c = :objectType');
    }

    public static LogLWC__c createLogLWC(LogLWCWrapper wrapper, Boolean serialize) {
        LogLWC__c logLWC = new LogLWC__c();
        logLWC.ObjectType__c = wrapper.objectType;
        logLWC.ActionType__c = wrapper.actionType;
        logLWC.Description__c = wrapper.description;
        logLWC.IsSuccessful__c = wrapper.isSuccessful;
        logLWC.ErrorMessage__c = wrapper.errorMessage;

        if (serialize) insert logLWC;

        return logLWC;
    }
}


