import 'package:despesas_androidx/src/blocs/login_bloc_provider.dart';
import 'package:despesas_androidx/src/ui/home/home.dart';
import 'package:despesas_androidx/src/utils/Route.dart';
import 'package:despesas_androidx/src/utils/Theme.dart' as theme;
import 'package:despesas_androidx/src/ui/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    return LoginBlocProvider(
      child: MaterialApp(
        title: 'Só Despesas :(',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: theme.primaryColor,
          fontFamily: theme.baseTextStyle.fontFamily,
          backgroundColor: Colors.white,
          primaryColor: theme.primaryColor,
        ),
        onGenerateRoute: (RouteSettings settings) => Routes.getRoute(settings),
        home: FutureBuilder<FirebaseUser>(
          future: _firebaseAuth.currentUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  print(
                      "Erro ao verificar estado do usuário: ${snapshot.error}");
                  return LoginPage();
                } else if (snapshot.data == null) {
                  return LoginPage();
                } else {
                  LoginBlocProvider.of(context).changeUser(snapshot.data);
                  return HomePage();
                }
            }
          },
        ),
      ),
    );
  }
}
