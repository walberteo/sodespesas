import 'package:despesas_androidx/pages/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static getRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(
          builder: (_) => new HomePage(
                title: 'Só Despesas :(',
              ),
        );
        break;
    }
  }

  static navigator(BuildContext context, String rota) {
    Navigator.of(context).pushNamed(rota);
  }
}
