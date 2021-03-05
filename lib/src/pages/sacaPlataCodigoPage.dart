import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:nequi/src/preferencias/preferences.dart';
import 'package:nequi/src/utils/colores.dart';

class SacaPlataCodigoPage extends StatefulWidget {
  SacaPlataCodigoPage({Key key}) : super(key: key);

  @override
  _SacaPlataCodigoPageState createState() => _SacaPlataCodigoPageState();
}

class _SacaPlataCodigoPageState extends State<SacaPlataCodigoPage> {
  FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: 0.0);
  MoneyFormatterOutput fo;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users;
  int value = 0;
  final prefs = UserPreferences();

  @override
  void initState() {
    users = firestore.collection('usuarios');
    fmf = FlutterMoneyFormatter(amount: value.toDouble());
    fo = fmf.output;
    _loadData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Scaffold(
          backgroundColor: Color(0xffc8f6f3),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colores.colorMorado,
            title: Center(
              child: Text(
                'Tu código',
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
          body: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                _banner(),
                SizedBox(
                  height: size.height * 0.2,
                ),
                _forma(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _banner() {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Estas sacando plata de: Disponible',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              '${fo.symbolOnLeft}',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget _forma() {
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      width: 200,
      height: 200,
      // top: 150.0,
      // height: 200,
      // width: 200,
      // left: 80,
      child: Stack(
        children: [
          RotationTransition(
            turns: new AlwaysStoppedAnimation(45 / 360),
            child: Container(
              width: size.width + 100,
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                color: Colores.colorMorado,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '466601',
                  style: TextStyle(color: Colors.white, fontSize: 40.0),
                ),
                Text(
                  'Vence en: 29:57',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          )
        ],
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
