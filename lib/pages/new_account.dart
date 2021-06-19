import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_password_chest2/models/account_model.dart';
import 'package:flutter_password_chest2/services/account_service.dart';
import 'package:provider/provider.dart';

class NewAccount extends StatefulWidget {
  static final routeName = '/new-page';

  @override
  _NewAccountState createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccount> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _disabledButton = false;

  AccountModel _accountModel = AccountModel();

  @override
  void dispose() {
    this._titleController.dispose();
    this._urlController.dispose();
    this._emailController.dispose();
    this._usernameController.dispose();
    this._passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xfff2f1f6),
      appBar: CupertinoNavigationBar(
        middle: Text('Create Account'),
        // trailing: Material(
        //   color: Colors.transparent,
        //   child: TextButton(
        //     onPressed: () {},
        //     child: Text('Save'),
        //   ),
        // ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 50.0,
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 30.0, left: 30.0, top: 10.0),
                child: CupertinoTextField(
                  placeholder: 'Title',
                  keyboardType: TextInputType.text,
                  controller: _titleController,
                  onChanged: (value) {
                    setState(() {
                      _accountModel.title = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              height: 50.0,
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 30.0, left: 30.0, top: 10.0),
                child: CupertinoTextField(
                  placeholder: 'Url',
                  keyboardType: TextInputType.url,
                  controller: _urlController,
                  onChanged: (value) {
                    setState(() {
                      _accountModel.url = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              height: 50.0,
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 30.0, left: 30.0, top: 10.0),
                child: CupertinoTextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  placeholder: 'Email',
                  onChanged: (value) {
                    setState(() {
                      _accountModel.email = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              height: 50.0,
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 30.0, left: 30.0, top: 10.0),
                child: CupertinoTextField(
                  keyboardType: TextInputType.visiblePassword,
                  suffix: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          this._obscureText = !this._obscureText;
                        });
                      },
                      icon: Icon(Icons.remove_red_eye_outlined),
                    ),
                  ),
                  controller: _passwordController,
                  obscuringCharacter: '•',
                  obscureText: _obscureText,
                  enableSuggestions: true,
                  placeholder: 'Password',
                  onChanged: (value) {
                    setState(() {
                      _accountModel.password = value;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 30.0, left: 30.0, top: 10.0),
              child: CupertinoButton(
                color: Colors.blue,
                child: Text('Save account'),
                onPressed: this._titleController.value.text.isNotEmpty
                    ? () {
                        final newAccount = Provider.of<AccountProvider>(context,
                            listen: false);
                        if (this._titleController.text.contains(' ')) {
                          return showCupertinoDialog(
                            context: context,
                            builder: (_) => CupertinoAlertDialog(
                              title: Text("The Title not be empty"),
                              actions: [
                                // Close the dialog
                                CupertinoButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                        newAccount.newAccount(this._accountModel);

                        final snackBar = SnackBar(
                          content: Text('Account saved successfuly'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
