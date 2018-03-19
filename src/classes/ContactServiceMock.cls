
public abstract with sharing class ContactServiceMock extends AbstractMock {

  protected override Object callMockedMethod(String stubbedMethodName, List<Object> listOfArgs) {

    if (stubbedMethodName == 'getContacts') {

      System.assertEquals(0, listOfArgs.size());
      return getContacts();

    }

    throw new MockException('Failed to find method for ' + stubbedMethodName);

  }

  public virtual List<Contact> getContacts() {
    throw newUnsupportedMethodException('getContacts');
  }
}