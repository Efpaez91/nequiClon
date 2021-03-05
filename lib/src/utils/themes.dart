import 'package:flutter/material.dart';
import 'package:nequi/src/utils/colores.dart';

class Themes {
  final pinkTheme = ThemeData(
    primaryColor: Color(0xfffc2f72),
    primarySwatch: Colores.colorRosado,
    scaffoldBackgroundColor: Colores.colorRosado,
    backgroundColor: Color(0xfffc2f72),
  );

  final purpleTheme = ThemeData(
    primaryColor: Color(0xff341759),
    primarySwatch: Colores.colorMorado,
    scaffoldBackgroundColor: Colores.colorMorado,
    backgroundColor: Color(0xff26004d),
  );
}
