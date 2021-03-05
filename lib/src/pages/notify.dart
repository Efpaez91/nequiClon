import 'package:flutter/material.dart';
import 'package:nequi/src/utils/colores.dart';

class NotifyPage extends StatefulWidget {
  NotifyPage({Key key}) : super(key: key);

  @override
  _NotifyPageState createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  final String noNotify = "En este momento no tienes notificaciones.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd5f8f4),
      appBar: AppBar(
        backgroundColor: Colores.colorMorado,
        title: Center(
          child: Text('Notificaciones'),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Stack(
            children: [
              _forma1(),
              _forma2(),
              Column(
                children: [
                  _bannerSuperior(),
                  _contentPage(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contentPage() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Image.asset(
                'assets/notificacion.jpg',
                width: 150.0,
              ),
              Text(
                noNotify,
                style: TextStyle(
                  color: Color(0xff418e8b),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bannerSuperior() {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Color(0xffe2fbf8),
        child: Row(
          children: [
            Container(
              width: size.width * 0.4,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                child: TextButton(
                  onPressed: null,
                  style: TextButton.styleFrom(
                    backgroundColor: Colores.colorRosado,
                  ),
                  child: Text(
                    'Recibidas (0)',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              width: size.width * 0.5,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 40.0),
                child: TextButton(
                  onPressed: null,
                  style: TextButton.styleFrom(
                      side: BorderSide(
                        color: Colors.grey[400],
                        width: 0.8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                  child: Text(
                    'En espera (0)',
                    style: TextStyle(color: Colors.grey[400]),
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
      top: 340.0,
      height: size.height,
      width: 280,
      left: 180,
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(-70 / 360),
        child: Container(
          width: size.width + 100,
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            color: Color(0xffe2fbf8),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _forma2() {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: -150.0,
      height: size.height,
      width: 280,
      left: -190,
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(20 / 360),
        child: Container(
          width: size.width + 100,
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            color: Color(0xffc8f6f3),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
