({
  loadAccounts: function (component) {

    var action = component.get('c.getAccounts'),
      state;

    action.setCallback(this,
      function(response) {
        state = response.getState();
        if (state === 'SUCCESS') {
          component.set('v.accounts', response.getReturnValue());
        } else {
          console.log('whoops.');
        }
      });

    $A.enqueueAction(action);
  },

  loadContacts: function (component) {

    var action = component.get('c.getContacts'),
      state;

    action.setCallback(this,
      function(response) {
        state = response.getState();
        if (state === 'SUCCESS') {
          component.set('v.contacts', response.getReturnValue());
        } else {
          console.log('failed to load contacts.');
        }
      });

    $A.enqueueAction(action);
  },

  associateAccountAndContact: function(component, selectedAccount, selectedContact) {
    var action = component.get('c.assignContactToAccount'),
      state;

    action.setParams({
      selectedAccount: selectedAccount,
      selectedContact: selectedContact
    });

    action.setCallback(this,
      function(response) {
        state = response.getState();
        if (state === 'SUCCESS') {
          component.set('v.successMessage', 'Success!');
          component.set('v.errorMessage', '');
        } else {
          component.set('v.successMessage', '');
          component.set('v.errorMessage', 'Failed!');
        }
      });

    $A.enqueueAction(action);
  }
});