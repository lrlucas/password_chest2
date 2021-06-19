import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfigPage extends StatelessWidget {
  static final routeName = '/config-page';
  const ConfigPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('Config Page'),
      ),
      body: Container(
        child: Center(
          child: Text('Config Page will come soon'),
        ),
      ),
    );
  }
}
