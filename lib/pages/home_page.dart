import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static final routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xfff2f1f6),
      appBar: CupertinoNavigationBar(
        middle: Text('My Accounts'),
        trailing: Material(
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ListTile(
              title: Text('Google'),
              subtitle: Text('lrlucas@gmail.com'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                print('tap en la lista');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: size.width,
        height: 90,
        color: Colors.white,
        child: SafeArea(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10),
                child: Icon(
                  Icons.settings,
                  size: 30.0,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, top: 10.0),
                child: Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return CupertinoPageScaffold(
  //     navigationBar: CupertinoNavigationBar(
  //       middle: Text('My Accounts'),
  //       trailing: Material(
  //         child: IconButton(
  //           onPressed: () {},
  //           icon: Icon(Icons.add),
  //         ),
  //       ),
  //     ),
  //     child: SingleChildScrollView(
  //       child: SafeArea(
  //         child: Material(
  //           child: Theme(
  //             data: ThemeData(
  //               splashColor: Colors.transparent,
  //             ),
  //             child: Column(
  //               children: [
  //                 ListTile(
  //                   title: Text('Google'),
  //                   subtitle: Text('lrlucas@gmail.com'),
  //                   trailing: Icon(Icons.arrow_forward_ios),
  //                   onTap: () {
  //                     print('tap en la lista');
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
