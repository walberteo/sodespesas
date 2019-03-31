import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

final baseTextStyle = TextStyle(
  fontFamily: 'Poppins',
);

final primaryColor = Color(0xff996BF5);
final secundaryColor = Color(0xff6143DF);

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
