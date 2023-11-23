


import 'package:hive_flutter/hive_flutter.dart';
part 'telemedicine_model.g.dart';

@HiveType(typeId: 5)
class TelemedicineModel extends HiveObject{

  @HiveField(0)
   int? id;

  @HiveField(1)
   String name;

  @HiveField(2)
   String address;

  @HiveField(3)
  String email;

  @HiveField(4)
  String mobile;

  @HiveField(5)
  String symptoms;

  @HiveField(6)
  String medicine;

  @HiveField(7)
  DateTime date;


  TelemedicineModel({required this.name,required this.address,required this.email,required this.mobile,required this.symptoms,required this.medicine,required this.date,this.id});
}
