import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glove_knitting_finishing/emp_box.dart';
import 'page2.dart';
import 'page3.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const String empBoxName = 'emp';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.registerAdapter(EmpBoxAdapter());
  await Hive.initFlutter(document.path);
  await Hive.openBox<EmpBox>(empBoxName);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new Scaffold(body: FinishingHome()),
  ));
}

class FinishingHome extends StatefulWidget {
  @override
  _FinishingHomeState createState() => _FinishingHomeState();
}

class _FinishingHomeState extends State<FinishingHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(50)),
                    color: Colors.green),
                margin: const EdgeInsets.all(5),
                padding: EdgeInsets.fromLTRB(2, 25, 100, 40),
                child: Column(
                  children: [
                    Icon(
                      Icons.settings,
                      size: 50,
                      color: Colors.white70,
                    ),
                    Text(
                      'Settings',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 2,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              Divider(),
              FlatButton(
                onPressed: () {
                  var emp = Hive.box<EmpBox>(empBoxName);
                  List<int> keys = emp.keys.cast<int>().toList();

                  int num = keys.length;
                  for (var i = 0; i < num; i++) {
                    final int key = keys[i];
                    final EmpBox boxV = emp.get(key);

                    final int cnt = 0;
                    EmpBox mTodo = EmpBox(
                        id: boxV.id,
                        name: boxV.name,
                        cnt: cnt,
                        style: boxV.style,
                        size: boxV.size);

                    emp.put(key, mTodo);
                  }
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.rate_review,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Create new',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Divider(),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => NewEmployeeDetails()),
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(Icons.person_add),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Add new employee',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              Divider(),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EmployeeList()));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Icon(Icons.account_box),
                      SizedBox(width: 10),
                      Text(
                        'View Employee details',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              Divider(),
              FlatButton(
                onPressed: () {
                  var emp = Hive.box<EmpBox>(empBoxName);
                  List<int> keys = emp.keys.cast<int>().toList();

                  int num = keys.length;
                  int cntVal = 0;
                  for (var i = 0; i < num; i++) {
                    //print('$i');
                    int key = keys[i];
                    var hive = emp.get(key).cnt;
                    cntVal = cntVal + hive;
                  }
                  final snackBar = SnackBar(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0))),
                    duration: new Duration(milliseconds: 1500),
                    content: Text(
                      'Total packed bins up to now: $cntVal',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.assignment),
                    SizedBox(width: 10),
                    Text(
                      'Summary',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Packing Production'),
        ),
        body: ValueListenableBuilder(
            valueListenable: Hive.box<EmpBox>(empBoxName).listenable(),
            builder: (context, Box<EmpBox> box, _) {
              List<int> keys = box.keys.cast<int>().toList();

              return ListView.separated(
                  itemBuilder: (_, index) {
                    final int key = keys[index];
                    final EmpBox boxv = box.get(key);

                    return Stack(children: [
                      ListTile(
                          leading: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: new SweepGradient(
                                colors: [
                                  Colors.orangeAccent,
                                  Colors.orangeAccent[700]
                                ],
                                transform: GradientRotation(0.523),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Text(
                              boxv.cnt.toString(),
                              textScaleFactor: 1.3,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          title: Text(
                            boxv.id.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor: 1.5,
                          ),
                          subtitle: Text(
                            boxv.name,
                            textScaleFactor: 1.5,
                          ),
                          dense: true,
                          hoverColor: Colors.lime,
                          //select style and size
                          trailing: Container(
                            padding: EdgeInsets.symmetric(),
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue[300],
                            ),
                            child: IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  int prd = boxv.cnt;
                                  final int sha = prd + 1;
                                  EmpBox e2 = EmpBox(
                                      id: boxv.id,
                                      name: boxv.name,
                                      cnt: sha,
                                      style: boxv.style,
                                      size: boxv.size);
                                  Hive.box<EmpBox>(empBoxName).put(key, e2);
                                }),
                          ),
                          onLongPress: () {
                            int prd = boxv.cnt;
                            if (prd > 0) {
                              final int sha = prd - 1;

                              EmpBox e2 = EmpBox(
                                  id: boxv.id,
                                  name: boxv.name,
                                  cnt: sha,
                                  style: boxv.style,
                                  size: boxv.size);
                              Hive.box<EmpBox>(empBoxName).put(key, e2);
                            } else {}
                          }),
                    ]);
                  },
                  separatorBuilder: (_, index) => Divider(),
                  itemCount: keys.length,
                  shrinkWrap: true);
            }));
  }
}
