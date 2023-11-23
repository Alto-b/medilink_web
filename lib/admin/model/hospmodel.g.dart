// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HospModelAdapter extends TypeAdapter<HospModel> {
  @override
  final int typeId = 0;

  @override
  HospModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HospModel(
      hosp: fields[1] as String,
      id: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HospModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.hosp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HospModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
