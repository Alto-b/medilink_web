

import 'package:hive_flutter/hive_flutter.dart';
part 'doctor_model.g.dart';

@HiveType(typeId: 3)
class DoctorModel{

  @HiveField(0)
  int? id;

  @HiveField(1)
   String name;

  @HiveField(2)
   String gender;

  @HiveField(3)
   String qualification;

  @HiveField(4)
   String dob;

  @HiveField(5)
   String doj;

  @HiveField(6)
   String hospital;

  @HiveField(7)
   String specialization;

  @HiveField(8)
  String photo; 

  DoctorModel({required this.name,required this.gender,required this.qualification,required this.dob,required this.doj,required this.hospital,required this.specialization,required this.photo, this.id});


}