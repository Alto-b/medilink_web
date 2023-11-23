// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deptmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DepartmentModelAdapter extends TypeAdapter<DepartmentModel> {
  @override
  final int typeId = 1;

  @override
  DepartmentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DepartmentModel(
      dept: fields[1] as String,
      photo: fields[2] as Uint8List,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, DepartmentModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dept)
      ..writeByte(2)
      ..write(obj.photo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DepartmentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
