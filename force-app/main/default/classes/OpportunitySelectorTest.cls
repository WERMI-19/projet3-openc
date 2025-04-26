@IsTest
private class OpportunitySelectorTest {

    @TestSetup
    static void setup() {
        Account testAccount = TestDataFactory.createTestAccount();
        TestDataFactory.createTestOpportunity(testAccount.Id);
    }

    @IsTest
    static void testGetOpportunitiesByAccountId() {
        // récupérer l'Account spécifique créé en TestSetup
        Account testAccount = [SELECT Id FROM Account WHERE Name = 'Test Account' LIMIT 1];

        Test.startTest();
        List<Opportunity> results = OpportunitySelector.getOpportunitiesByAccountId(testAccount.Id);
        Test.stopTest();

        // utiliser System.assertNotEquals
        System.assertNotEquals(0, results.size(), 'Devrait renvoyer au moins une opportunité.');
    }
}
