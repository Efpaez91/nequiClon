import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nequi/src/preferencias/preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController numeroController = new TextEditingController();
  String cellphone = "";
  final placeholderNumero = "311 676 6136";
  final indicativo = "+57";
  final textButton = "Entra";
  final textHelp = "Ayuda";
  final colorFondo = Color(0xff26004d);
  final colorMoradoClaro = Color(0xff260b5a);
  final colorMorado = Color(0xff240550);
  final colorRosa = Color(0xffc1246b);
  final colorMorado2 = Color(0xff341759);
  final colorQr = Color(0xff7aa5c9);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final prefs = UserPreferences();
  CollectionReference users;
  @override
  void initState() {
    super.initState();
    numeroController.text = "";
    users = firestore.collection('usuarios');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorFondo,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Stack(
            children: [
              _forma2(),
              _forma1(),
              Column(
                children: [
                  _logo(),
                  SizedBox(
                    height: size.height * 0.45,
                  ),
                  Expanded(
                    child: Container(
                      alignment: FractionalOffset.bottomCenter,
                      child: _bannerInferior(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bannerInferior() {
    return Container(
      alignment: FractionalOffset.bottomCenter,
      child: Column(
        children: [
          _numeroTelefonico(),
          SizedBox(
            height: 10.0,
          ),
          _button(),
          SizedBox(
            height: 10.0,
          ),
          _footer(),
        ],
      ),
    );
  }

// forma color mas claro
  Widget _forma1() {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: size.height * 0.82,
      height: 500,
      left: -150,
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(15 / 360),
        child: Container(
          width: size.width + 100,
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            color: colorMoradoClaro,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

// esta es la forma mas oscura que va atras
  Widget _forma2() {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: size.height * 0.85,
      height: 500,
      left: 50,
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(40 / 360),
        child: Container(
          width: size.width + 100,
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            color: colorMorado,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

// este es el logo nequi
  Widget _logo() {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Container(
        child: Image.asset(
          'assets/logo_nequi.png',
          scale: 1.5,
        ),
      ),
    );
  }

// este es el campo para agregar el numero
  Widget _numeroTelefonico() {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Container(
            height: 50.0,
            width: size.width * 0.2,
            decoration: BoxDecoration(
              color: colorFondo,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 1.5),
              child: TextFormField(
                controller: numeroController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: colorRosa,
                ),
                decoration: InputDecoration(
                  hintText: '311 676 6136',
                  filled: true,
                  fillColor: colorMorado2,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintStyle: TextStyle(
                    color: colorRosa,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12),
                    child: Container(
                      width: size.width * 0.13,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: colorFondo,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 9.0, left: 9.0),
                        child: Text(
                          '+57',
                          style: TextStyle(
                            color: colorRosa,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                maxLines: 5,
                onChanged: (value) {
                  cellphone = value.toString();
                  setState(() {});
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

// este es el boton de entrar
  Widget _button() {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: size.width * 0.9,
        child: TextButton(
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Text(
              textButton,
              style: TextStyle(
                color: colorRosa,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          onPressed: () async {
            if (cellphone.length == 10) {
              await users.where('cellphone', isEqualTo: cellphone).get().then(
                (QuerySnapshot querySnapshot) {
                  if (querySnapshot.docs.isEmpty) {
                    _openDialog();
                  } else {
                    querySnapshot.docs.forEach(
                      (element) {
                        if (element['cellphone'] == cellphone) {
                          prefs.cellphone = cellphone;
                          prefs.userId = element.id;
                          Navigator.pushNamed(context, 'login');
                        }
                      },
                    );
                  }
                },
              );
            } else {
              _openDialog();
            }
          },
          style: TextButton.styleFrom(
            side: BorderSide(
              color: colorRosa,
              width: 0.8,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
      ),
    );
  }

// esta es la seccion de abajo del todo
  Widget _footer() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _textoHelp(),
            _iconoQr(),
            _logoBanco(),
          ],
        ),
      ),
    );
  }

// texto de ayuda
  Widget _textoHelp() {
    return Text(
      textHelp,
      style: TextStyle(color: Colors.white),
    );
  }

// icono qr
  Widget _iconoQr() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: colorQr,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          child: Icon(
            Icons.qr_code,
            color: colorQr,
            size: 22,
          ),
        ),
      ),
    );
  }

  // Logo bancolombia
  Widget _logoBanco() {
    return Image(
      image: AssetImage('assets/by bancolombia.jpg'),
      width: 50.0,
    );
  }

// modal notificar un error
  _openDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: colorMorado2.withOpacity(0.5),
          actions: [
            TextButton(
              child: Text(
                'Aceptar',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          title: Text(
            'Por favor',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  'Verifiqué el número telefónico',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
