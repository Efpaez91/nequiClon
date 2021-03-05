import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:nequi/src/preferencias/preferences.dart';
import 'package:nequi/src/utils/colores.dart';

class SacaPlataPage extends StatefulWidget {
  SacaPlataPage({Key key}) : super(key: key);

  @override
  _SacaPlataPageState createState() => _SacaPlataPageState();
}

class _SacaPlataPageState extends State<SacaPlataPage> {
  String title = 'Saca plata';
  FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: 0.0);
  MoneyFormatterOutput fo;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users;
  final prefs = UserPreferences();
  int value = 0;

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          backgroundColor: Color(0xffc8f6f3),
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
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                alignment: Alignment.topCenter,
                width: size.width,
                height: size.height * 0.88,
                child: Stack(
                  children: [
                    _forma1(),
                    _forma2(),
                    Column(
                      children: [
                        _bannerUp(),
                        _cards(),
                        // _botonContinuar(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cards() {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          _cardCajero(),
          _cardPuntoFisico(),
          _bannerDow(),
          Container(
            height: size.height * 0.3,
            alignment: Alignment.bottomCenter,
            child: Text(
              'Ayuda',
              style: TextStyle(
                color: Colores.colorMorado[200].withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bannerUp() {
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
              '¡Hey! Esta operación te cuesta',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              '\$ 0,00',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget _bannerDow() {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width,
        color: Color(0xffe9fcfa),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Encuentra dónde sacar plata',
                style: TextStyle(color: Color(0xff72c7c9)),
              ),
              Row(
                children: [
                  Icon(
                    Icons.place,
                    color: Color(0xff72c7c9),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Color(0xff72c7c9),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardCajero() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          _goToSacaPlata();
        },
        child: Card(
          color: Colors.white,
          child: ListTile(
            leading: Image(
              image: AssetImage('assets/cajero.jpg'),
              width: 80.0,
            ),
            trailing: Padding(
              padding: EdgeInsets.only(top: 40, bottom: 20),
              child: Icon(
                Icons.keyboard_arrow_right,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Cajero',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Saca plata desde un cajero Bancolombia',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Saca hasta: ${fo.symbolOnLeft}',
                      style: TextStyle(
                        color: Colores.colorMorado,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '¿Cómo lo uso?',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardPuntoFisico() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          _goToSacaPlata();
        },
        child: Card(
          color: Colors.white,
          child: ListTile(
            leading: Image(
              image: AssetImage('assets/puntoFisico.jpg'),
              width: 80.0,
            ),
            trailing: Padding(
              padding: EdgeInsets.only(top: 40, bottom: 20),
              child: Icon(
                Icons.keyboard_arrow_right,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Punto físico',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Retira plata solo en corresponsales Nequi.',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Saca hasta: ${fo.symbolOnLeft}',
                      style: TextStyle(
                        color: Colores.colorMorado,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '¿Cómo lo uso?',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
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
      top: size.height * 0.75,
      height: 500,
      width: 500,
      left: -200,
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(30 / 360),
        child: Container(
          width: size.width + 100,
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            color: Color(0xffd6f9f5),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _forma2() {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: size.height * 0.7,
      height: 700,
      width: 700,
      left: 50,
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(75 / 360),
        child: Container(
          width: size.width + 100,
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            color: Color(0xffddfaf6),
            borderRadius: BorderRadius.circular(10),
          ),
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

  _goToSacaPlata() {
    Navigator.pushNamed(context, 'codigo');
  }
}
