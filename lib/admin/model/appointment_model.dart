
import 'package:hive/hive.dart';
part 'appointment_model.g.dart';

@HiveType(typeId: 6)
class AppointmentModel extends HiveObject{

  @HiveField(0)
   int? id;

  @HiveField(1)
   String name;

   @HiveField(2)
   String gender;

   @HiveField(3)
   String dob;

   @HiveField(4)
   String marital;

   @HiveField(5)
   String email;

   @HiveField(6)
   String mobile;

   @HiveField(7)
   String address;

   @HiveField(8)
   String title;

   @HiveField(9)
   final DateTime date;

   @HiveField(10)
   final String user;

   AppointmentModel({required this.name,required this.gender,required this.dob,required this.marital,required this.email,required this.mobile,required this.address,required this.title,required this.date,required this.user, this.id});
  
}
