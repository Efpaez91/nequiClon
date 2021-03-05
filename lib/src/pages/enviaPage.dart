import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:nequi/src/preferencias/preferences.dart';
import 'package:nequi/src/utils/colores.dart';

class EnviaPage extends StatefulWidget {
  EnviaPage({Key key}) : super(key: key);

  @override
  _EnviaPageState createState() => _EnviaPageState();
}

class _EnviaPageState extends State<EnviaPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users;
  final prefs = UserPreferences();
  String title = "¿Cuál quieres usar?";
  String disponible = "Disponible";
  int value = 0;
  FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: 0.0);
  MoneyFormatterOutput fo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    users = firestore.collection('usuarios');
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    fo = fmf.output;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colores.colorMorado,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colores.colorMorado,
          title: Center(
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: 26.0,
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: Container(
            alignment: Alignment.topCenter,
            width: size.width,
            height: size.height * 0.894,
            child: Stack(
              children: [
                _forma1(),
                _forma2(),
                Column(
                  children: [
                    _contenido(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contenido() {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50.0,
            left: 30.0,
            right: 30.0,
          ),
          child: Container(
            height: size.height * 0.2,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'enviaPlata');
              },
              child: Card(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, right: 30.0),
                      child: Container(
                        height: 40,
                        alignment: Alignment.topRight,
                        child: _forma3(),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 15.0, left: 15.0, bottom: 0),
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              disponible,
                              style: TextStyle(
                                color: Colores.colorMorado,
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              '${fo.symbolOnLeft}',
                              style: TextStyle(
                                color: Colores.colorMorado,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ), // Column()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _forma1() {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: size.height * 0.7,
      height: 500,
      width: 500,
      left: -90,
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(-40 / 360),
        child: Container(
          width: size.width + 100,
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            color: Colores.colorMorado[200],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _forma2() {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: size.height * 0.75,
      height: 700,
      width: 700,
      left: 50,
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(75 / 360),
        child: Container(
          width: size.width + 100,
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            color: Colores.colorMorado[300].withOpacity(0.7),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _forma3() {
    return RotationTransition(
      turns: new AlwaysStoppedAnimation(40 / 360),
      child: Container(
        width: 40,
        height: 50,
        decoration: BoxDecoration(
          color: Colores.colorRosado,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  _loadData() async {
    await users.doc(prefs.userId).get().then(
      (querySnapshot) {
        value = querySnapshot.data()['dinero'];
        fmf = FlutterMoneyFormatter(amount: value.toDouble());
        fo = fmf.output;
        setState(() {});
      },
    );
  }
}
