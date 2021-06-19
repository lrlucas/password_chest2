import 'package:flutter/material.dart';
import 'package:flutter_password_chest2/pages/config_page.dart';
import 'package:flutter_password_chest2/theme/custom_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_password_chest2/pages/edit_page.dart';
import 'package:flutter_password_chest2/pages/home_page.dart';
import 'package:flutter_password_chest2/pages/new_account.dart';
import 'package:flutter_password_chest2/services/account_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AccountProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Accounts',
        // agregar los temas oscuros y claro para cuando se cambie en ios,
        // se cambia en la app
        // theme: ThemeData(
        //   brightness: Brightness.light,
        //   primarySwatch: Colors.blue,
        //   splashFactory: InkRipple.splashFactory,
        // ),
        theme: CustomTheme.lightTheme,
        darkTheme: CustomTheme.darkTheme,
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (_) => HomePage(),
          NewAccount.routeName: (_) => NewAccount(),
          EditPage.routeName: (_) => EditPage(),
          ConfigPage.routeName: (_) => ConfigPage(),
        },
      ),
    );
  }
}
