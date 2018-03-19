
@IsTest
private class GoodControllerTest {

  @IsTest
  static void testGetAccountsSuccess() {

    AccountService.setMock((AccountService) Test.createStub(AccountService.class,
        new AccountServiceSuccessMock()));
    Test.startTest();
    List<Account> accounts = GoodController.getAccounts();
    Test.stopTest();

    System.assertEquals(1, accounts.size(), 'Should have a single account.');

  }

  @IsTest
  static void testGetAccountsException() {

    AccountService.setMock((AccountService) Test.createStub(AccountService.class,
        new AccountServiceExceptionMock()));
    String errorMessage = '';

    Test.startTest();
    try {
      List<Account> accounts = GoodController.getAccounts();
    } catch (AuraHandledException ahe) {
      errorMessage = ahe.getMessage();
    }
    Test.stopTest();

    System.assertEquals(GoodController.ACCOUNT_ERROR, errorMessage, 'Should have a account error.');

  }

  @IsTest
  static void testGetContactsSuccess() {
    ContactService.setMock((ContactService) Test.createStub(ContactService.class,
        new ContactServiceSuccessMock()));
    Test.startTest();
    List<Contact> contacts = GoodController.getContacts();
    Test.stopTest();

    System.assertEquals(1, contacts.size(), 'Should have gotten list of contacts.');
  }

  @IsTest
  static void testGetContactsException() {
    ContactService.setMock((ContactService) Test.createStub(ContactService.class,
        new ContactServiceExceptionMock()));
    String errorMessage = '';
    Test.startTest();
    try {
      List<Contact> contacts = GoodController.getContacts();
    } catch (AuraHandledException e) {
      errorMessage = e.getMessage();
    }
    Test.stopTest();

    System.assertEquals(GoodController.CONTACTS_ERROR, errorMessage, 'Should have gotten a contact error.');
  }

  @IsTest
  static void testAssignContactToAccountSuccess() {

    Account account = new Account(Name = 'fakeAccount');
    insert account;

    Contact contact = new Contact(FirstName = 'test', LastName = 'User' );
    insert contact;

    AccountService.setMock((AccountService) Test.createStub(AccountService.class,
        new AccountServiceUpdateMock(contact, account)));

    Test.startTest();
    Boolean result = GoodController.assignContactToAccount(account, contact);
    Test.stopTest();

    System.assertEquals(true, result, 'Should have successful response.');
  }

  @IsTest
  static void testAssignContactToAccountException() {

    AccountService.setMock((AccountService) Test.createStub(AccountService.class,
        new AccountServiceExceptionMock()));

    String errorMessage = '';
    Boolean result;

    Test.startTest();
    try {
      result = GoodController.assignContactToAccount(null, null);
    } catch (AuraHandledException ahe) {
      errorMessage = ahe.getMessage();
    }
    Test.stopTest();

    System.assertEquals(GoodController.OWNER_ERROR, errorMessage, 'Should have a owner error.');

  }

  class AccountServiceSuccessMock extends AccountServiceMock {
    private List<Account> accounts;

    public AccountServiceSuccessMock() {
      Account a = new Account(Name = 'account1');
      insert a;
      accounts = new List<Account>{a};
    }

    public override List<Account> getAccounts() {
      return accounts;
    }

  }

  class AccountServiceUpdateMock extends AccountServiceMock {
    private Account updateAccount;
    private Contact updateContact;

    public AccountServiceUpdateMock(Contact contact, Account account) {
      this.updateContact = contact;
      this.updateAccount = account;
    }

    public override Boolean updateAccountOwner(Contact contact, Account account) {
      System.assertEquals(contact.Id, this.updateContact.Id);
      System.assertEquals(account.Id, this.updateAccount.Id);
      return true;
    }
  }

  class AccountServiceExceptionMock extends AccountServiceMock {

    public override List<Account> getAccounts() {
      throw new ServiceException('No Way.');
    }

    public override Boolean updateAccountOwner(Contact contact, Account account) {
      throw new ServiceException('No Association here.');
    }

  }

  class ContactServiceSuccessMock extends ContactServiceMock {
    private List<Contact> contacts;

    public ContactServiceSuccessMock() {
      Contact contact = new Contact(FirstName = 'Mock', LastName = 'User');
      insert contact;
      contacts = new List<contact>{contact};
    }

    public override List<Contact> getContacts() {
      return contacts;
    }
  }

  class ContactServiceExceptionMock extends ContactServiceMock {
    private List<Contact> contacts;

    public override List<Contact> getContacts() {
      throw new ServiceException('No Contacts Here.');
    }
  }
}