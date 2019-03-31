import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static getRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/sparkbar':
        // return MaterialPageRoute(
        //    builder: (_) => new SparkBar.withSampleData(),
        //   settings: settings,
        // );
        break;
    }
  }

  static navigator(BuildContext context, String rota) {
    Navigator.of(context).pushNamed(rota);
  }
}
