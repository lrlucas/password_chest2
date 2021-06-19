import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_password_chest2/models/account_model.dart';
import 'package:flutter_password_chest2/pages/config_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_password_chest2/pages/edit_page.dart';
import 'package:flutter_password_chest2/services/account_service.dart';

import 'new_account.dart';

class HomePage extends StatefulWidget {
  static final routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<AccountProvider>(context, listen: false).loadAccounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final accountList = Provider.of<AccountProvider>(context);
    final accounts = accountList.accounts;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CupertinoNavigationBar(
        middle: Text(
          'My Accounts',
          style: TextStyle(
            color: Theme.of(context).primaryTextTheme.bodyText1.color,
          ),
        ),
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        trailing: Material(
          color: Colors.transparent,
          child: IconButton(
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder: (_) => CupertinoAlertDialog(
                  title: Text("Delete all accounts"),
                  content: Text("Are you sure?"),
                  actions: [
                    // Close the dialog
                    CupertinoButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    CupertinoButton(
                      child: Text('Delete all'),
                      onPressed: () {
                        accountList.deleteAll();
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              );
            },
            icon: Icon(Icons.delete),
          ),
        ),
      ),
      body: accounts.length == 0
          ? Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.hourglass_empty_outlined,
                      size: 40.0,
                    ),
                    Text(
                      'No Accounts',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.separated(
              itemCount: accounts.length,
              itemBuilder: (BuildContext context, i) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    showCupertinoDialog(
                      context: context,
                      builder: (_) => CupertinoAlertDialog(
                        title: Text('Delete account ${accounts[i].title}?'),
                        content: Text("Are you sure?"),
                        actions: [
                          // Close the dialog
                          CupertinoButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              accountList.loadAccounts();
                              Navigator.of(context).pop();
                            },
                          ),
                          CupertinoButton(
                            child: Text('Delete!'),
                            onPressed: () {
                              setState(() {
                                accountList.deleteAccountById(accounts[i].id);
                              });
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ),
                    );
                  },
                  secondaryBackground: Container(
                    child: Center(
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    color: Colors.red,
                  ),
                  background: Container(),
                  child: ListTile(
                    tileColor: Theme.of(context).dialogBackgroundColor,
                    title: Text(
                      accounts[i].title ?? '',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.bodyText1.color,
                      ),
                    ),
                    subtitle: Text(
                      accounts[i].email ?? '',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.bodyText1.color,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onLongPress: () {
                      print('onLongPress');
                      print(accounts[i].password ?? '');
                      Clipboard.setData(ClipboardData(
                        text: accounts[i].password ?? '',
                      ));
                      final snackBar = SnackBar(
                        content: Text('password copied to clipboard'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    onTap: () {
                      // ir a editar la cuenta
                      print('tap en la lista');
                      print(accounts[i].id);
                      Navigator.pushNamed(
                        context,
                        EditPage.routeName,
                        arguments: AccountModel(
                          id: accounts[i].id,
                          title: accounts[i].title,
                          email: accounts[i].email,
                          url: accounts[i].url,
                          password: accounts[i].password,
                        ),
                      );
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
      bottomNavigationBar: Container(
        width: size.width,
        height: 90,
        color: Theme.of(context).dialogBackgroundColor,
        child: SafeArea(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 10),
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    icon: Icon(
                      Icons.settings,
                      size: 30.0,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, ConfigPage.routeName);
                    },
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 25.0, top: 10.0),
                child: Material(
                  color: Colors.transparent,
                  child: Theme(
                    data: ThemeData(
                      splashColor: Colors.transparent,
                      hintColor: Colors.transparent,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        size: 30,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, NewAccount.routeName);
                        // CupertinoPageRoute(builder: (context) => NewAccount());
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
