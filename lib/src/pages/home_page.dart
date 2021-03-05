import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nequi/src/pages/modalPage.dart';
import 'package:nequi/src/preferencias/preferences.dart';
import 'package:nequi/src/utils/colores.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final text1 = "Disponible";
  int value = 0;
  final text2 = "Total";
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users;
  final prefs = UserPreferences();

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height * 0.9,
          child: Center(
            child: _contenido(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) => ModalPage(),
            ),
          );
        },
        child: Center(
          child: Text(
            '\$',
            style: TextStyle(fontSize: 25.0),
          ),
        ),
        backgroundColor: Colores.colorRosado,
      ),
    );
  }

  Widget _contenido() {
    return Container(
      child: Stack(
        children: [
          _forma1(),
          _forma2(),
          _textValue(),
          _contentItems(),
        ],
      ),
    );
  }

// forma de color rosado
  Widget _forma1() {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: -10.0,
      height: 280,
      width: 280,
      left: 170,
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(-20 / 360),
        child: Container(
          width: size.width + 100,
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            color: Colores.colorRosado,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }

// forma de color morado
  Widget _forma2() {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: -20.0,
      height: 300,
      width: 300,
      left: 180,
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(25 / 360),
        child: Container(
          width: size.width + 100,
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            color: Colores.colorMorado,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

// texto que va en la forma 2
  Widget _textValue() {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: 50.0,
      height: 280,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          alignment: Alignment.centerRight,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text1,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '${fo.symbolOnLeft}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              Text(
                text2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '${fo.symbolOnLeft}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// contenido 3 items principales
  Widget _contentItems() {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 130.0, left: 20.0),
        child: Container(
          width: size.width,
          height: size.height * 0.2,
          child: Row(
            children: [
              _button('assets/alcancia.png', 'Metas'),
              _button('assets/colchon.png', 'Colchón'),
              _button('assets/bolsillos.png', 'Bolsillos'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button(String image, String texto) {
    return Container(
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image),
            Text(
              texto,
              style: TextStyle(color: Colores.colorMorado),
            )
          ],
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
