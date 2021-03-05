import 'package:flutter/material.dart';
import 'package:nequi/src/utils/colores.dart';

class ModalPage extends StatefulWidget {
  ModalPage({Key key}) : super(key: key);

  @override
  _ModalPageState createState() => _ModalPageState();
}

class _ModalPageState extends State<ModalPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colores.colorMorado.withOpacity(0.85),
      body: Center(
        child: Container(
          width: size.width,
          height: size.height * 0.6,
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 25.0, bottom: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _listTile('assets/escaneaQR.png', 'Escanea QR', false, ''),
                _listTile(
                    'assets/EnviaPlata.png', 'Envía plata', true, 'envia'),
                _listTile('assets/sacaPlata.png', 'Saca plata', true, 'saca'),
                _listTile('assets/recargaTuCuenta.png', 'Recarga tu cuenta',
                    false, ''),
                _listTile('assets/pidePlata.png', 'Pide plata', false, ''),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 55.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Center(
            child: Text(
              'X',
              style: TextStyle(fontSize: 25.0, color: Colors.white),
            ),
          ),
          backgroundColor: Color(0xff2fc9d4),
        ),
      ),
    );
  }

  Widget _listTile(icono, text, click, origen) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (click == true) {
          switch (origen) {
            case 'envia':
              Navigator.pushNamed(context, 'envia');
              break;
            case 'saca':
              Navigator.pushNamed(context, 'saca');
              print('saca');
              break;
          }
        }
      },
      child: Container(
        width: size.width * 0.6,
        child: ListTile(
          title: Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          trailing: Image.asset(
            icono,
            width: 50.0,
          ),
        ),
      ),
    );
  }
}
