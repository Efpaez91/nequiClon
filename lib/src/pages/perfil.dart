import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nequi/src/preferencias/preferences.dart';
import 'package:nequi/src/utils/colores.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class PerfilPage extends StatefulWidget {
  PerfilPage({Key key}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference perfilCollection;
  final prefs = UserPreferences();
  String photoProfile =
      "https://w7.pngwing.com/pngs/893/926/png-transparent-silhouette-user-icon-profile-silhouette-silhouette-avatar-profile-silhouette.png";
  String nombre = "";
  String cellPhone = "";
  File imageUpload;
  String imageFile;

  @override
  void initState() {
    perfilCollection = firestore.collection('usuarios');
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colores.colorMorado,
      body: Center(
        child: Container(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              _bannerSuperior(size),
              _bannerInferior(size),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bannerSuperior(size) {
    return Container(
      width: size.width,
      height: size.height * 0.25,
      child: Stack(
        children: [
          _forma1(),
          _forma2(),
          Row(
            children: [
              _avatar(),
              _informacion(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bannerInferior(size) {
    return Expanded(
      child: Container(
        width: size.width,
        child: Column(
          children: [
            Card(
              shape: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              color: Colores.colorMorado,
              child: ListTile(
                title: Text(
                  'Tu cuenta',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Card(
              shape: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              color: Colores.colorMorado,
              child: ListTile(
                trailing: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                title: Text(
                  'Ajustes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Card(
              shape: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              color: Colores.colorMorado,
              child: ListTile(
                title: Text(
                  'Mi QR',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Card(
              shape: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              color: Colores.colorMorado,
              child: ListTile(
                title: Text(
                  'Documentación',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Card(
              color: Colores.colorMorado,
              elevation: 0,
              child: ListTile(
                title: Text(
                  'Ayuda',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: FractionalOffset.bottomLeft,
                child: GestureDetector(
                  onTap: () {
                    prefs.destroyData();
                    Navigator.pushNamed(context, '/');
                  },
                  child: ListTile(
                    title: Text(
                      'Cierra sesión',
                      style: TextStyle(
                        color: Colores.colorRosado,
                      ),
                    ),
                    leading: Icon(
                      Icons.power_settings_new_outlined,
                      color: Colores.colorRosado,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _avatar() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, bottom: 15.0),
        child: Container(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {
              _showSelectionDialog(context);
            },
            child: CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(photoProfile),
            ),
          ),
        ),
      ),
    );
  }

  Widget _informacion() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 70.0, left: 40),
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                nombre,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'Cuenta Nequi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                cellPhone,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _forma1() {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: -30.0,
      height: size.height,
      width: 280,
      left: 180,
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(-65 / 360),
        child: Container(
          width: size.width + 100,
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            color: Colores.colorMorado[50],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _forma2() {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: -40.0,
      height: size.height,
      width: 280,
      left: -70,
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(75 / 360),
        child: Container(
          width: size.width + 100,
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            color: Colores.colorMorado[100].withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  loadData() async {
    await perfilCollection.doc(prefs.userId).get().then(
      (querySnapshot) {
        print('============== info =============');
        print(querySnapshot.data());
        photoProfile = querySnapshot.data()['photoProfile'];
        nombre = querySnapshot.data()['username'];
        cellPhone = querySnapshot.data()['cellphone'];
        setState(() {});
      },
    );
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Selecione una opcion para la imagen."),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Galeria"),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camara"),
                      onTap: () {
                        _openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageUpload = picture;
    });
    uploadImg(imageUpload);
    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageUpload = picture;
    });
    uploadImg(imageUpload);
    Navigator.of(context).pop();
  }

  Future uploadImg(img) async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(prefs.cellphone + '/perfil - ' + prefs.userId)
          .putFile(img)
          .then(
        (data) async {
          String downloadURL = await firebase_storage.FirebaseStorage.instance
              .ref(data.ref.fullPath)
              .getDownloadURL();
          imageFile = downloadURL;
          updateProfile({'photoProfile': imageFile});
        },
      );
    } catch (e) {
      print(e);
    }
  }

  updateProfile(data) {
    perfilCollection.doc(prefs.userId).update(data).then(
      (value) {
        photoProfile = imageFile;
        setState(() {});
      },
    ).catchError((error) => print(error));
  }
}
