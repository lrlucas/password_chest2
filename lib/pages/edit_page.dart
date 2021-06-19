import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_password_chest2/models/account_model.dart';
import 'package:flutter_password_chest2/services/account_service.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  static final routeName = '/edit';

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  AccountModel _accountModel = AccountModel();

  @override
  void dispose() {
    this._titleController.dispose();
    this._urlController.dispose();
    this._emailController.dispose();
    this._passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context).settings.arguments as AccountModel;
    _titleController.text = args.title ?? '';
    _accountModel.title = args.title ?? '';
    this._titleController.selection = TextSelection.fromPosition(
        TextPosition(offset: this._titleController.text.length));
    _accountModel.id = args.id;
    _urlController.text = args.url ?? '';
    _accountModel.url = args.url;
    _emailController.text = args.email ?? '';
    _accountModel.email = args.email;
    _passwordController.text = args.password ?? '';
    _accountModel.password = args.password;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xfff2f1f6),
      appBar: CupertinoNavigationBar(
        middle: Text('Edit Account'),
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
                onPressed: () async {
                  final res =
                      await accountProvider.updateAccount(_accountModel);
                  if (res != null) {
                    final snackBar = SnackBar(
                      content: Text('Account updated successfuly'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
