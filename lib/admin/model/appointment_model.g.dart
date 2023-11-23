// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppointmentModelAdapter extends TypeAdapter<AppointmentModel> {
  @override
  final int typeId = 6;

  @override
  AppointmentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppointmentModel(
      name: fields[1] as String,
      gender: fields[2] as String,
      dob: fields[3] as String,
      marital: fields[4] as String,
      email: fields[5] as String,
      mobile: fields[6] as String,
      address: fields[7] as String,
      title: fields[8] as String,
      date: fields[9] as DateTime,
      user: fields[10] as String,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, AppointmentModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.gender)
      ..writeByte(3)
      ..write(obj.dob)
      ..writeByte(4)
      ..write(obj.marital)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.mobile)
      ..writeByte(7)
      ..write(obj.address)
      ..writeByte(8)
      ..write(obj.title)
      ..writeByte(9)
      ..write(obj.date)
      ..writeByte(10)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppointmentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
