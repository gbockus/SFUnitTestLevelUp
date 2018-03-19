
public abstract with sharing class AccountServiceMock extends AbstractMock {

  protected override Object callMockedMethod(String stubbedMethodName, List<Object> listOfArgs) {

    if (stubbedMethodName == 'getAccounts') {

      System.assertEquals(0, listOfArgs.size());
      return getAccounts();

    } else if (stubbedMethodName == 'updateAccountOwner') {

      System.assertEquals(2, listOfArgs.size());
      Contact contact = (Contact) listOfArgs[0];
      Account account = (Account) listOfArgs[1];

      return updateAccountOwner(contact, account);
    }

    throw new MockException('Failed to find method for ' + stubbedMethodName);

  }

  public virtual List<Account> getAccounts() {
    throw newUnsupportedMethodException('getAccounts');
  }

  public virtual boolean updateAccountOwner(Contact contact, Account account) {
    throw newUnsupportedMethodException('updateAccountOwner');
  }
}