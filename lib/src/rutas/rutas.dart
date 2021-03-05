import 'package:flutter/cupertino.dart';
import 'package:nequi/src/pages/enviaPage.dart';
import 'package:nequi/src/pages/enviaPlataForm.dart';
import 'package:nequi/src/pages/login_page.dart';
import 'package:nequi/src/pages/login_page_step2.dart';
import 'package:nequi/src/pages/navigationBar.dart';
import 'package:nequi/src/pages/sacaPlaraPage.dart';
import 'package:nequi/src/pages/sacaPlataCodigoPage.dart';

Map<String, WidgetBuilder> rutasGenerales() {
  return {
    '/': (context) => LoginPage(),
    'home': (context) => NavigationBarPage(),
    'login': (context) => LoginPageStep2(),
    'envia': (context) => EnviaPage(),
    'enviaPlata': (context) => EnviaPlataForm(),
    'saca': (context) => SacaPlataPage(),
    'codigo': (context) => SacaPlataCodigoPage()
  };
}
