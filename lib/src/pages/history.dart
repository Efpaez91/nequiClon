import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:nequi/src/preferencias/preferences.dart';
import 'package:nequi/src/utils/colores.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  TextEditingController searchController = new TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference historyCollection;
  final prefs = UserPreferences();
  String search;
  List<dynamic> history = [];
  FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: 0.0);
  MoneyFormatterOutput fo;

  @override
  void initState() {
    historyCollection = firestore.collection('historial');
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffc8f6f3),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              children: [
                _buscador(),
                SizedBox(
                  height: 15.0,
                ),
                _contenido(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buscador() {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: ListTile(
        title: Container(
          height: 50.0,
          width: size.width * 0.2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 8.0, top: 1.5),
            child: TextFormField(
              controller: searchController,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Busca ...',
                hoverColor: Colors.white,
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                prefixIcon: IconButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    searchController.text = '';
                    setState(
                      () {},
                    );
                  },
                  icon: Icon(Icons.search),
                  color: Colors.grey,
                ),
              ),
              maxLines: 5,
              onChanged: (value) {
                search = value;
                setState(() {});
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _contenido() {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        width: size.width,
        color: Color(0xffd5f8f4),
        child: _historial(),
      ),
    );
  }

  Widget _historial() {
    final size = MediaQuery.of(context).size;
    // var newMap = groupBy(history, (obj) => obj['fecha']);
    // print(newMap);
    // quede aca
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          if (history[index]['motivo'] == 'Reintegro') {
            return Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                width: size.width * 0.8,
                child: Card(
                  color: Colors.white,
                  child: ListTile(
                    title: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                '${history[index]['motivo']}',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 11),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                '${history[index]['monto']}',
                                style: TextStyle(
                                    color: Colors.green[400], fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          alignment: AlignmentDirectional.bottomStart,
                          child: Text(
                            '${history[index]['descripcion']}',
                            style: TextStyle(
                                color: Colors.green[400], fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                width: size.width * 0.8,
                child: Card(
                  color: Colors.white,
                  child: ListTile(
                    title: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                '${history[index]['motivo']}',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 11),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional.topEnd,
                              child: Text(
                                '${history[index]['monto']}',
                                style: TextStyle(
                                    color: Colores.colorRosado, fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          alignment: AlignmentDirectional.bottomStart,
                          child: Text(
                            '${history[index]['descripcion']}',
                            style: TextStyle(
                                color: Colores.colorRosado, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  loadData() async {
    await historyCollection
        .where('usuario', isEqualTo: prefs.userId)
        .get()
        .then(
      (querySnapshot) {
        querySnapshot.docs.forEach(
          (element) {
            fmf = FlutterMoneyFormatter(amount: double.parse(element['monto']));
            fo = fmf.output;
            history.add(
              {
                'descripcion': element['Descripcion'],
                'motivo': element['motivo'],
                'fecha': element['fecha'],
                'monto': fo.symbolOnLeft,
              },
            );
          },
        );
        setState(() {});
      },
    );
  }
}
