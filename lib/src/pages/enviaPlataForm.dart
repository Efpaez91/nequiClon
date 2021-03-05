import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nequi/src/preferencias/preferences.dart';
import 'package:nequi/src/utils/colores.dart';

class EnviaPlataForm extends StatefulWidget {
  EnviaPlataForm({Key key}) : super(key: key);

  @override
  _EnviaPlataFormState createState() => _EnviaPlataFormState();
}

class _EnviaPlataFormState extends State<EnviaPlataForm> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference perfilCollection;
  CollectionReference historyCollection;
  final prefs = UserPreferences();
  String title = "Envia Plata";
  String cellphone = "";
  String cantidad = "";
  String mensaje = "";
  int value = 0;
  bool isEnabled = false;
  // TextEditingController cellphoneController = new TextEditingController();
  // TextEditingController cantidadController = new TextEditingController();
  // TextEditingController mensajeController = new TextEditingController();

  @override
  void initState() {
    perfilCollection = firestore.collection('usuarios');
    historyCollection = firestore.collection('historial');
    loadData();
    // TODO: implement initState
    super.initState();
    // cellphoneController.text = "";
    // cantidadController.text = "";
    // mensajeController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
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
              height: size.height * 0.894,
              child: Stack(
                children: [
                  _forma1(),
                  _forma2(),
                  Column(
                    children: [
                      _contenido(),
                      _cardDonde(),
                      _botonContinuar(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _botonContinuar() {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: size.width * 0.9,
          child: RaisedButton(
            color: Colores.colorRosado,
            disabledColor: Colores.colorRosado[200],
            child: Text(
              'Continúa',
              style: TextStyle(color: Colors.white),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            onPressed: isEnabled
                ? () {
                    processData();
                  }
                : null,
          ),
        ),
      ),
    );
  }

  Widget _contenido() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          color: Color(0xffeefcfc),
          child: ExpansionTile(
            backgroundColor: Color(0xffeefcfc),
            initiallyExpanded: true,
            title: Text(
              'Envia a nequi',
              style: TextStyle(
                color: Color(0xff0da2a2),
              ),
            ),
            children: [
              _formulario(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formulario() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              initialValue: cellphone,
              decoration: InputDecoration(
                labelText: 'Celular',
                labelStyle: TextStyle(
                  color: Color(0xffcdd0d1),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    '+',
                    style: TextStyle(
                      color: Color(0xff7bb0ae),
                    ),
                  ),
                ),
              ),
              onChanged: (value) {
                cellphone = value;
                if (cellphone.length > 0 &&
                    cantidad.length > 0 &&
                    mensaje.length > 0) {
                  isEnabled = true;
                } else {
                  isEnabled = false;
                }
                setState(() {});
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              initialValue: cantidad,
              decoration: InputDecoration(
                labelText: 'Cantidad',
                labelStyle: TextStyle(
                  color: Color(0xffcdd0d1),
                ),
              ),
              onChanged: (value) {
                cantidad = value;
                if (cellphone.length > 0 &&
                    cantidad.length > 0 &&
                    mensaje.length > 0) {
                  isEnabled = true;
                } else {
                  isEnabled = false;
                }
                setState(() {});
              },
            ),
            TextFormField(
              initialValue: mensaje,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Mensaje',
                labelStyle: TextStyle(
                  color: Color(0xffcdd0d1),
                ),
              ),
              onChanged: (value) {
                mensaje = value;
                if (cellphone.length > 0 &&
                    cantidad.length > 0 &&
                    mensaje.length > 0) {
                  isEnabled = true;
                } else {
                  isEnabled = false;
                }
                setState(() {});
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }

  Widget _cardDonde() {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.15,
      width: size.width * 0.96,
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              color: Color(0xffeefcfc),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, left: 12.0, bottom: 8.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '¿De dónde saldrá la plata?',
                    style: TextStyle(
                      color: Color(0xff0da2a2),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: _forma3(),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Disponible',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 150.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
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

  Widget _forma3() {
    return RotationTransition(
      turns: new AlwaysStoppedAnimation(40 / 360),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colores.colorRosado,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  loadData() async {
    await perfilCollection.doc(prefs.userId).get().then(
      (querySnapshot) {
        print('============== info =============');
        print(querySnapshot.data());
        value = querySnapshot.data()['dinero'];
        setState(() {});
      },
    );
  }

  processData() async {
    var price1 = value;
    var price2 = int.parse(cantidad);
    var total = price1 - price2;
    // value = total.toString();
    if (total < 0) {
      _openDialog();
    } else {
      updateProfile({'dinero': total});
      print(total);
    }
  }

  updateProfile(data) {
    perfilCollection.doc(prefs.userId).update(data).then(
      (value) async {
        var date = new DateTime.now().toString();
        var data = {
          "Descripcion": mensaje,
          "fecha": date,
          "monto": cantidad,
          "motivo": "Envio",
          "usuario": prefs.userId,
        };
        await historyCollection.add(data).then(
          (querySnapshot) {
            setState(() {});
          },
        );
        Navigator.pushNamed(context, 'home');
      },
    ).catchError((error) => print(error));
  }

  // modal notificar un error
  _openDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xffc8f6f3),
          actions: [
            TextButton(
              child: Text(
                'Aceptar',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          title: Text(
            'Fondos insuficientes!',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  'Verifiqué el monto a enviar.',
                  style: TextStyle(
                    color: Colors.black,
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
