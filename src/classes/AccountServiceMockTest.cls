/**
 * Created by gbockus on 3/19/18.
 */

@IsTest
private class AccountServiceMockTest {

  @IsTest
  static void testUnimplemented() {
    AccountService.setMock((AccountService) Test.createStub(AccountService.class,
        new AccountServiceMockImpl()));
    String errorMessage;

    Test.startTest();
    try {
      AccountService.getInstance().fakeForTesting();
    } catch (Exception e) {
      errorMessage = e.getMessage();
    }
    Test.stopTest();

    System.assertNotEquals(null, errorMessage, 'Should have encounted an error');
    System.assertEquals('Failed to find method for fakeForTesting', errorMessage, 'Verify setup error.');

  }

  @IsTest
  static void testGetAccountsUnimplmented() {
    AccountService.setMock((AccountService) Test.createStub(AccountService.class,
        new AccountServiceMockImpl()));
    String errorMessage;

    Test.startTest();
    try {
      AccountService.getInstance().getAccounts();
    } catch (Exception e) {
      errorMessage = e.getMessage();
    }
    Test.stopTest();

    System.assertNotEquals(null, errorMessage, 'Should have encounted an error');
    System.assertEquals('getAccounts must be implemented.', errorMessage, 'Verify getAccounts setup error.');
  }

  @IsTest
  static void testUpdateAccountOwnerUnimplmented() {
    AccountService.setMock((AccountService) Test.createStub(AccountService.class,
        new AccountServiceMockImpl()));
    String errorMessage;

    Test.startTest();
    try {
      AccountService.getInstance().updateAccountOwner(null, null);
    } catch (Exception e) {
      errorMessage = e.getMessage();
    }
    Test.stopTest();

    System.assertNotEquals(null, errorMessage, 'Should have encounted an error');
    System.assertEquals('updateAccountOwner must be implemented.', errorMessage, 'Verify updateAccountOwner setup error.');
  }


  class AccountServiceMockImpl extends AccountServiceMock {}
}