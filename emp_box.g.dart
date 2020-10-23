// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmpBoxAdapter extends TypeAdapter<EmpBox> {
  @override
  final int typeId = 0;

  @override
  EmpBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmpBox(
      id: fields[0] as int,
      name: fields[1] as String,
      cnt: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, EmpBox obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.cnt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmpBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
