import 'package:hive/hive.dart';

part 'emp_box.g.dart';

@HiveType(typeId: 0)
class EmpBox {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int cnt;

  @HiveField(3)
  String style;

  @HiveField(4)
  int size;

  @HiveField(5)
  bool torp;

  EmpBox({this.id, this.name, this.cnt, this.style, this.size});

  static listenable() {}
}
