public inherited sharing class LogManager {

    public static final String DEFAULT_TYPE = 'DEBUG';
    
    public class LogWrapper {
        public String logType {get; set;}
        public String message {get; set;}
    }

    public static List<Log__c> getLogsByIds(List<Id> ids, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Log__c WHERE Id IN :ids');
    }

    public static List<Log__c> getLogsByTypes(List<Type> types, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Log__c WHERE Type__c IN :types');
    }

    public static Log__c createLog(LogWrapper wrapper ,Boolean serialize) {
        Log__c log = new Log__c();
        log.Type__c = String.isNotBlank(wrapper.logType) ? wrapper.logType : DEFAULT_TYPE;
        log.Message__c = wrapper.message;

        if (serialize) insert log;

        return log;
    }
}
