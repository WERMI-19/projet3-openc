public with sharing class AccountCasesController {

    @AuraEnabled(cacheable=true)
    public static List<Case> findCasesBySubject(Id accountId, String subjectSearchTerm) {
        if (accountId == null) {
            return new List<Case>();
        }
             // filtrer par mot-clé
        String searchKey = '%' + subjectSearchTerm + '%';
        return [
            SELECT Id, Subject, Status, Priority
            FROM Case
            WHERE AccountId = :accountId
              AND Subject LIKE :searchKey
            ORDER BY CreatedDate DESC
            LIMIT 50
        ];
    }
}
