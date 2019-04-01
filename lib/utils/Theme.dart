import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

final baseTextStyle = TextStyle(
  fontFamily: 'Poppins',
);

final primaryColor = Colors.indigo;
final secundaryColor = Colors.blue;

final headerTextStyle = baseTextStyle.copyWith(
  color: Colors.white,
  fontSize: 22.0,
  fontWeight: FontWeight.w400,
);

final regularTextStyle = baseTextStyle.copyWith(
  color: const Color(0xffb6b2df),
  fontSize: 9.0,
  fontWeight: FontWeight.w400,
);

final subHeaderTextStyle = regularTextStyle.copyWith(
  fontSize: 12.0,
);
