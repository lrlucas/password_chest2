import 'package:flutter/material.dart';
import 'package:flutter_password_chest2/models/account_model.dart';
import 'package:flutter_password_chest2/provider/db_provider.dart';

class AccountProvider extends ChangeNotifier {
  List<AccountModel> accounts = [];

  newAccount(AccountModel accountModel) async {
    final id = await DBProvider.db.newAccount(accountModel);
    if (id != null) {
      accountModel.id = id;
      this.accounts.add(accountModel);
      notifyListeners();
    }
    notifyListeners();
  }

  updateAccount(AccountModel accountModel) async {
    final res = await DBProvider.db.updateAccount(accountModel);
    this.loadAccounts();
    // notifyListeners();
    return res;
  }

  loadAccounts() async {
    final accounts = await DBProvider.db.getAccounts();
    this.accounts = [...accounts];
    notifyListeners();
  }

  deleteAll() async {
    await DBProvider.db.deleteAllAccounts();
    this.accounts = [];
    notifyListeners();
  }

  deleteAccountById(int id) async {
    await DBProvider.db.deleteAccountById(id);
    this.loadAccounts();
    // notifyListeners();
  }
}
