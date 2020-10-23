import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'main.dart';
import 'package:glove_knitting_finishing/emp_box.dart';

class EmployeeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employes'),
        backgroundColor: Colors.green,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<EmpBox>(empBoxName).listenable(),
        builder: (context, Box<EmpBox> box, _) {
          List<int> keys = box.keys.cast<int>().toList();

          return ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                final int key = keys[index];
                final EmpBox boxv = box.get(key);

                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(boxv.name),
                  subtitle: Text(boxv.id.toString()),
                  dense: true,
                  hoverColor: Colors.lime,
                  onLongPress: () {
                    showDialog(
                      context: context,
                      child: Dialog(
                        insetPadding: EdgeInsets.all(25),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                height: 60,
                                child: Center(
                                    child: Text('Delete employee details?'))),
                            Container(
                              color: Colors.grey,
                              padding: EdgeInsets.symmetric(),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FlatButton(
                                      color: Colors.cyan[200],
                                      onPressed: () {
                                        Hive.box<EmpBox>(empBoxName)
                                            .delete(key);
                                        Navigator.pop(context);
                                      },
                                      child: Text('Yes')),
                                  FlatButton(
                                      color: Colors.cyan[200],
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('No'))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (_, index) => Divider(),
              itemCount: keys.length,
              shrinkWrap: true);
        },
      ),
    );
  }
}
