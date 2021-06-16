import 'package:flutter/material.dart';

import '../pages/login_pages.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color.fromRGBO(136, 14, 79, 1);
    final primaryColorDark = Color.fromRGBO(96, 0, 39, 1);
    final primaryColorLight = Color.fromRGBO(188, 71, 123, 1);
    return MaterialApp(
      title: 'MyApp',
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
          background: Colors.white,
          primary: primaryColor,
          primaryVariant: primaryColorDark,
          surface: Colors.white,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: primaryColorDark),
        ),
      ),
      home: LoginPage(),
    );
  }
}
