import 'dart:io';
import 'package:flutter_password_chest2/models/account_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Accounts.db');
    // /Users/lucassuarez/Library/Developer/CoreSimulator/Devices/8399E25D-8CD4-4451-A92A-D195EE7744B6/data/Containers/Data/Application/E147854C-7129-4C88-99D5-DF37A518DD20/Documents/Accounts.db
    // crear db
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE account(
            id INTEGER PRIMARY KEY,
            title TEXT,
            url TEXT,
            email TEXT,
            password TEXT
          )
        ''');
    });
  }

  // create account
  Future<int> newAccount(AccountModel accountModel) async {
    final db = await database;
    final res = await db.insert('account', accountModel.toJson());
    return res;
  }

  // get account by id
  Future<AccountModel> getAccountById(int id) async {
    final db = await database;
    final res = await db.query('account', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? AccountModel.fromJson(res.first) : null;
  }

  // get all accounts
  Future<List<AccountModel>> getAccounts() async {
    final db = await database;
    final res = await db.query('account');
    return res.isNotEmpty
        ? res.map((e) => AccountModel.fromJson(e)).toList()
        : [];
  }

  // update account
  Future<int> updateAccount(AccountModel accountModel) async {
    final db = await database;
    final res = await db.update('account', accountModel.toJson(),
        where: 'id = ?', whereArgs: [accountModel.id]);
    return res;
  }

  // delete account by id
  Future<int> deleteAccountById(int id) async {
    final db = await database;
    final res = db.delete('account', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  // delete all accounts
  Future<int> deleteAllAccounts() async {
    final db = await database;
    final res = db.delete('account');
    return res;
  }
}
