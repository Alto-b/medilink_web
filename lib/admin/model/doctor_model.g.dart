// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoctorModelAdapter extends TypeAdapter<DoctorModel> {
  @override
  final int typeId = 3;

  @override
  DoctorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoctorModel(
      name: fields[1] as String,
      gender: fields[2] as String,
      qualification: fields[3] as String,
      dob: fields[4] as String,
      doj: fields[5] as String,
      hospital: fields[6] as String,
      specialization: fields[7] as String,
      photo: fields[8] as String,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, DoctorModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.gender)
      ..writeByte(3)
      ..write(obj.qualification)
      ..writeByte(4)
      ..write(obj.dob)
      ..writeByte(5)
      ..write(obj.doj)
      ..writeByte(6)
      ..write(obj.hospital)
      ..writeByte(7)
      ..write(obj.specialization)
      ..writeByte(8)
      ..write(obj.photo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
