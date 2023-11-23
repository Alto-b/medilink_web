

import 'package:hive/hive.dart';
part 'usermodel.g.dart';

@HiveType(typeId: 2)
class UserModel{

  @HiveField(0)
  int? id;

  @HiveField(1)
  final String fullname;

  @HiveField(2)
  final String dob;

  @HiveField(3)
  final String gender;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final String password;

  UserModel({required this.fullname,required this.dob,required this.gender,required this.email,required this.password});
}