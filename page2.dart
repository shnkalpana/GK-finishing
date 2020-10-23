import 'package:flutter/material.dart';
import 'package:glove_knitting_finishing/emp_box.dart';
import 'package:hive/hive.dart';
import 'main.dart';

class NewEmployeeDetails extends StatefulWidget {
  @override
  _NewEmployeeDetailsState createState() => _NewEmployeeDetailsState();
}

class _NewEmployeeDetailsState extends State<NewEmployeeDetails> {
  Box<EmpBox> empBox;

  final TextEditingController _empName = TextEditingController();

  final TextEditingController _empNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    empBox = Hive.box<EmpBox>(empBoxName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('New employee register'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                TextField(
                  decoration: new InputDecoration(
                    hintText: 'Enter name',
                  ),
                  textAlign: TextAlign.center,
                  controller: _empName,
                ),
                TextField(
                  decoration: new InputDecoration(
                    hintText: 'Enter employee number',
                  ),
                  textAlign: TextAlign.center,
                  controller: _empNumber,
                ),
                SizedBox(
                  height: 150,
                ),
                FlatButton(
                    onPressed: () {
                      final String ename = _empName.text;
                      String unt = _empNumber.text;
                      final eid = int.parse(unt);
                      String stl = 'EMEA';

                      EmpBox emp =
                          EmpBox(id: eid, name: ename, cnt: 00, style: stl);

                      empBox.add(emp);
                      _empName.clear();
                      _empNumber.clear();
                    },
                    color: Colors.grey,
                    child: Text(
                      'Save',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
