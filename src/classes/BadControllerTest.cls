
@IsTest
private class BadControllerTest {

  @IsTest
  static void testGetAccounts() {

    Test.startTest();
    List<Account> accts = BadController.getAccounts();
    Test.stopTest();

    System.assertEquals(0, accts.size(), 'Should have found zero accounts');
  }

  @IsTest
  static void testGetContacts() {

    Test.startTest();
    List<Contact> contacts = BadController.getContacts();
    Test.stopTest();

    System.assertEquals(0, contacts.size(), 'Should have found zero contacts');

  }

  @IsTest
  static void testAssignContactToAccount() {
    List<Profile> profiles = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];

    User u = new User();
    u.Username = 'totallyfakeusernameforunittest@email.com';
    u.LastName = 'Smith';
    u.Email = 'g@b.com';
    u.Alias = 'flints';
    u.CommunityNickname = 'abc123';
    u.LanguageLocaleKey = 'en_US';
    u.LocaleSidKey = 'en_US';
    u.ProfileId = profiles.get(0).Id;
    u.TimeZoneSidKey = 'America/Los_Angeles';
    u.EmailEncodingKey = 'UTF-8';
    insert u;

    Account a = new Account();
    a.Name = 'fake';
    insert a;

    Contact c = new Contact();
    c.LastName = 'Taylor';
    c.OwnerId = u.Id;
    insert c;

    Test.startTest();
    BadController.assignContactToAccount(a, c);
    Test.stopTest();

    Account updatedAccount = [Select Id, OwnerId from Account where Id = :a.id];
    System.assertNotEquals(null, updatedAccount, 'Should have found an account');
    System.assertEquals(a.OwnerId, c.OwnerId, 'Should have assoicated contact with account.');
  }
}