import 'package:despesas_androidx/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:despesas_androidx/utils/Theme.dart' as theme;
import 'package:despesas_androidx/utils/Route.dart';

import 'package:despesas_androidx/pages/home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Só Despesas :(',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: theme.primaryColor,
          fontFamily: theme.baseTextStyle.fontFamily,
          backgroundColor: Colors.white,
          primaryColor: theme.primaryColor,
        ),
        onGenerateRoute: (RouteSettings settings) => Routes.getRoute(settings),
        home: LoginPage() //HomePage(title: 'Só Despesas :('),
        );
  }
}
