import 'package:flutter/material.dart';
import 'package:nequi/src/utils/colores.dart';

class ArmarioPage extends StatefulWidget {
  ArmarioPage({Key key}) : super(key: key);

  @override
  _ArmarioPageState createState() => _ArmarioPageState();
}

class _ArmarioPageState extends State<ArmarioPage> {
  List<String> items = [
    "Tarjeta Nequi",
    "Préstamo Salvavidas",
    "Préstamo Paracaídas",
    "Recarga de celular",
    "Recarga Cívica",
    "Netflix",
    "Paypal",
    "PlayStation",
    "Servicios Publicos",
    "Ventas por Catálogo",
    "Xbox",
    "Pago de boletas"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd5f8f4),
      appBar: AppBar(
        backgroundColor: Colores.colorMorado,
        title: Center(child: Text('Armario')),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              _bannerSuperior(),
              _panelInferior(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bannerSuperior() {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Image.asset(
        'assets/banner.jpg',
        width: size.width,
      ),
    );
  }

  Widget _panelInferior() {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(
              items.length,
              (index) {
                return Container(
                  width: size.width * 0.1,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/$index.jpg',
                          width: 60,
                        ),
                        Expanded(
                          // fit: BoxFit.fitWidth,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              items[index],
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
