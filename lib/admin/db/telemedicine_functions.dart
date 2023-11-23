

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medilink/admin/model/telemedicine_model.dart';

ValueNotifier<List<TelemedicineModel>> telemedicineListNotifier=ValueNotifier([]);

//to add telemedicine enquiry
Future<void> addTelemedicine(TelemedicineModel value) async{
  final teleDB = await Hive.openBox<TelemedicineModel>('telemedicine_db');
  final id=await teleDB.add(value);
  final data = teleDB.get(id);
  await teleDB.put(id,TelemedicineModel(name: data!.name, address: data!.address, email: data!.email, mobile: data!.mobile, symptoms: data!.symptoms, medicine: data!.medicine,date: data!.date,id: id) );
  getTelemedicine();
}

//to read telemedicine
// Future<void> getTelemedicine() async{
//   final teleDB = await Hive.openBox<TelemedicineModel>('telemedicine_db');
//   telemedicineListNotifier.value.clear();
//   telemedicineListNotifier.value.addAll(teleDB.values);
//   telemedicineListNotifier.notifyListeners();
// }
Future<void> getTelemedicine() async {
  final teleDB = await Hive.openBox<TelemedicineModel>('telemedicine_db');
  telemedicineListNotifier.value.clear();
  telemedicineListNotifier.value.addAll(teleDB.values);

  // Sort the list based on the last date in descending order
  telemedicineListNotifier.value.sort((a, b) => b.date.compareTo(a.date));

  telemedicineListNotifier.notifyListeners();
}


//to remove telemedicine enquiry
Future<void> deleteTelemedicine(int id) async{
  final teleDB = await Hive.openBox<TelemedicineModel>('telemedicine_db');
  await teleDB.delete(id);
  getTelemedicine();
}

//to get telemedicine count
Future<int> telemedicineStats() async{
  final teleDB = await Hive.openBox<TelemedicineModel>('telemedicine_db');
  final telemedicineCount=teleDB.length;
  return telemedicineCount;
}