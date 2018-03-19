public abstract with sharing class AccountDaoMock extends AbstractMock {


  protected override Object callMockedMethod(String stubbedMethodName, List<Object> listOfArgs) {

    if (stubbedMethodName == 'getAccount') {

      System.assertEquals(0, listOfArgs.size());
      return getAccounts();

    }

    throw new MockException('Failed to find method for ' + stubbedMethodName);

  }

  public virtual List<Account> getAccounts() {
    throw newUnsupportedMethodException('getAccounts');
  }
}