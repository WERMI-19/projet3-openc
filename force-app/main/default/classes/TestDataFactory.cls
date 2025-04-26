@IsTest
public class TestDataFactory {

    public static Account createTestAccount() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        return acc;
    }

    public static Opportunity createTestOpportunity(Id accountId) {
        // Vérifier que l'Account Id est valide
        if (accountId == null) {
            throw new IllegalArgumentException('AccountId ne doit pas être null.');
        }

        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = System.today().addDays(30),
            Amount = 10000,
            AccountId = accountId
        );
        insert opp;
        return opp;
    }

    public static Case createTestCase(Id accountId) {
        // Vérifier que l'Account Id est valide
        if (accountId == null) {
            throw new IllegalArgumentException('AccountId ne doit pas être null.');
        }

        Case newCase = new Case(
            Subject = 'Incident réseau',
            Status = 'New',
            Priority = 'High',
            AccountId = accountId
        );
        insert newCase;
        return newCase;
    }
}

