// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telemedicine_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TelemedicineModelAdapter extends TypeAdapter<TelemedicineModel> {
  @override
  final int typeId = 5;

  @override
  TelemedicineModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TelemedicineModel(
      name: fields[1] as String,
      address: fields[2] as String,
      email: fields[3] as String,
      mobile: fields[4] as String,
      symptoms: fields[5] as String,
      medicine: fields[6] as String,
      date: fields[7] as DateTime,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, TelemedicineModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.mobile)
      ..writeByte(5)
      ..write(obj.symptoms)
      ..writeByte(6)
      ..write(obj.medicine)
      ..writeByte(7)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TelemedicineModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
