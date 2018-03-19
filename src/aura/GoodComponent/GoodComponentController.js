({
  doInit: function(component, event, helper) {
    helper.loadAccounts(component);
    helper.loadContacts(component);
  },

  selectAccount: function(component, event, helper) {
    console.log('select Account');
    console.log(event);
    var id = event.target.id,
      accounts = component.get('v.accounts');

    accounts.forEach(function(acct) {
      if (acct.Id === id) {
        component.set('v.selectedAccount', acct);
      }
    });

  },

  selectContact: function(component, event, helper) {
    console.log('select Contact');
    console.log(event);
    var id = event.target.id,
      contacts = component.get('v.contacts');

    contacts.forEach(function (contact) {
      if (contact.Id === id) {
        component.set('v.selectedContact', contact);
      }
    });
  },

  associatedContactAccount: function(component, event, helper) {
    var selectedAcct = component.get('v.selectedAccount'),
      selectedContact = component.get('v.selectedContact');
    helper.associateAccountAndContact(component, selectedAcct, selectedContact);
  }
});