import 'package:despesas/components/GradientAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:despesas/utils/Theme.dart' as theme;

class MyAppBar extends StatelessWidget {
  final String title;

  MyAppBar({Key key, this.title}) : super(key: key);

  @override
  GradientAppBar build(BuildContext context) {
    return GradientAppBar(
      title: Text(
        title,
        style: theme.headerTextStyle,
      ),
      brightness: Brightness.dark,
      backgroundColorStart: theme.primaryColor,
      backgroundColorEnd: theme.secundaryColor,
    );
  }
}
