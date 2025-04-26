// J#ai ajouter cette classe pour tester la classe AccountCasesController
@IsTest
private class AccountCasesControllerTest {

    @TestSetup
    static void setup() {
        // Création d'un compte de test
        Account testAccount = TestDataFactory.createTestAccount();
        // Création d'un Case de test lié à ce compte
        TestDataFactory.createTestCase(testAccount.Id);
    }

    @IsTest
    static void testFindCasesBySubject_withSubject() {
        // Récupération de l'account créé en test setup
        Account testAccount = [SELECT Id FROM Account WHERE Name = 'Test Account' LIMIT 1];

        Test.startTest();
        // Appel de la méthode que l'on teste
        List<Case> results = AccountCasesController.findCasesBySubject(testAccount.Id, 'Incident');
        Test.stopTest();

        // Vérification que la liste retournée contient au moins un Case
        System.assertNotEquals(null, results, 'La liste de cases ne doit pas être null.');
        System.assert(results.size() > 0, 'Il doit y avoir au moins un Case correspondant au sujet recherché.');
    }
}
