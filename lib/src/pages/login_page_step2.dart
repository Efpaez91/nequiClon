import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nequi/src/preferencias/preferences.dart';
import 'package:nequi/src/utils/colores.dart';

class LoginPageStep2 extends StatefulWidget {
  LoginPageStep2({Key key}) : super(key: key);

  @override
  _LoginPageStep2State createState() => _LoginPageStep2State();
}

class _LoginPageStep2State extends State<LoginPageStep2> {
  final title = "Pon tu clave";
  final subTitle = "No dudamos que seas tú, pero igual ingresa tu clave.";
  final olvido = "¿Se te olvidó?";
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List password = [];
  final prefs = UserPreferences();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colores.colorRosado,
      appBar: AppBar(
        backgroundColor: Colores.colorRosado,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height * 0.89,
            child: Stack(
              children: [
                _forma1(),
                _forma2(),
                _contenido(),
              ],
            ),
          ),
        ),
      ),
    );
  }

// forma larga
  Widget _forma1() {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: size.height * 0.70,
      height: 500,
      left: 80,
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(40 / 360),
        child: Container(
          width: size.width + 100,
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            color: Colores.colorRosado[100].withOpacity(0.5),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

// forma triangular
  Widget _forma2() {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: size.height * 0.70,
      height: 300,
      left: -130,
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(20 / 360),
        child: Container(
          width: size.width + 100,
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            color: Colores.colorRosado[50].withOpacity(0.45),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  Widget _contenido() {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              _bannerSuperior(size),
              SizedBox(
                height: size.height * 0.15,
              ),
              _teclado(size),
              SizedBox(
                height: 10.0,
              ),
              // _button(),
              SizedBox(
                height: 10.0,
              ),
              _footer(),
            ],
          ),
        ),
      ],
    );
  }

  // banner de la contraseña
  Widget _bannerSuperior(size) {
    return Container(
      width: size.width,
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            width: size.width * 0.6,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          password.length == 1 || password.length > 1
                              ? Text(
                                  '*',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                )
                              : _fieldsPass(size),
                          password.length == 2 || password.length > 2
                              ? Text(
                                  '*',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                )
                              : _fieldsPass(size),
                          password.length == 3 || password.length > 3
                              ? Text(
                                  '*',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                )
                              : _fieldsPass(size),
                          password.length == 4 || password.length > 4
                              ? Text(
                                  '*',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                )
                              : _fieldsPass(size),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              subTitle,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

// campos para la contraseña
  Widget _fieldsPass(size) {
    return RotationTransition(
      turns: new AlwaysStoppedAnimation(45 / 360),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
      ),
    );
  }

// teclado en pantalla
  Widget _teclado(size) {
    return Container(
      width: size.width,
      height: size.height * 0.47,
      child: Center(
        child: Container(
          width: size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // primeros numeros
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          if (password.length < 4) {
                            password.add(1);
                            setState(() {});
                          }
                          _navigateTo();
                        },
                        child: Text(
                          "1",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    child: Center(
                      child: GestureDetector(
                        child: Text(
                          "2",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        onTap: () {
                          if (password.length < 4) {
                            password.add(2);
                            setState(() {});
                          }
                          _navigateTo();
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    child: Center(
                      child: GestureDetector(
                        child: Text(
                          "3",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        onTap: () {
                          if (password.length < 4) {
                            password.add(3);
                            setState(() {});
                          }
                          _navigateTo();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              // segundos numeros
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    child: Center(
                      child: GestureDetector(
                        child: Text(
                          "4",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        onTap: () {
                          if (password.length < 4) {
                            password.add(4);
                            setState(() {});
                          }
                          _navigateTo();
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    child: Center(
                      child: GestureDetector(
                        child: Text(
                          "5",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        onTap: () {
                          if (password.length < 4) {
                            password.add(5);
                            setState(() {});
                          }
                          _navigateTo();
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    child: Center(
                      child: GestureDetector(
                        child: Text(
                          "6",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        onTap: () {
                          if (password.length < 4) {
                            password.add(6);
                            setState(() {});
                          }
                          _navigateTo();
                        },
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 10,
              ),

              // terceros numeros
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    child: Center(
                      child: GestureDetector(
                        child: Text(
                          "7",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        onTap: () {
                          if (password.length < 4) {
                            password.add(7);
                            setState(() {});
                          }
                          _navigateTo();
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    child: Center(
                      child: GestureDetector(
                        child: Text(
                          "8",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        onTap: () {
                          if (password.length < 4) {
                            password.add(8);
                            setState(() {});
                          }
                          _navigateTo();
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    child: Center(
                      child: GestureDetector(
                        child: Text(
                          "9",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        onTap: () {
                          if (password.length < 4) {
                            password.add(9);
                            setState(() {});
                          }
                          _navigateTo();
                        },
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 10,
              ),

              // ultima fila
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          if (password.length < 4) {
                            password.add(0);
                            setState(() {});
                          }
                          _navigateTo();
                        },
                        child: Text(
                          "0",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (password.length > 0) {
                        password.removeLast();
                        setState(() {});
                      }
                      _navigateTo();
                    },
                    child: RotationTransition(
                      turns: new AlwaysStoppedAnimation(180 / 360),
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Center(
                          child: Stack(
                            children: [
                              Icon(
                                Icons.label_rounded,
                                color: Colors.white,
                                size: 50,
                              ),
                              Positioned(
                                top: 15,
                                left: 12,
                                child: Icon(
                                  Icons.close,
                                  color: Colores.colorRosado,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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

  _navigateTo() async {
    CollectionReference users = firestore.collection('usuarios');
    await users.where('cellphone', isEqualTo: prefs.cellphone).get().then(
      (QuerySnapshot querySanapshot) {
        querySanapshot.docs.forEach(
          (element) {
            if (password.length == 4) {
              var pass = password.toString();
              pass = pass.replaceAll('[', '');
              pass = pass.replaceAll(']', '');
              pass = pass.replaceAll(',', '');
              pass = pass.replaceAll(' ', '');
              if (pass == element['password']) {
                Navigator.pushNamed(context, 'home');
                password = [];
              } else {
                _openDialog();
              }
            }
          },
        );
      },
    );
  }

// se te olvido
  Widget _footer() {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        alignment: FractionalOffset.bottomLeft,
        decoration: BoxDecoration(
          color: Colores.colorRosado[200],
          border: Border(
            top: BorderSide(
              color: Colores.colorRosado[900],
              width: 2,
            ),
          ),
        ),
        child: Center(
          child: Text(
            olvido,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

// modal notificar un error
  _openDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colores.colorRosado.withOpacity(0.5),
          actions: [
            TextButton(
              child: Text(
                'Aceptar',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                password = [];
                Navigator.of(context).pop();
                setState(() {});
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
                  'Verifiqué La clave',
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
