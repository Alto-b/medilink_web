
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medilink/admin/db/dept_functions.dart';
import 'package:medilink/admin/model/hospmodel.dart';

ValueNotifier<List<HospModel>> hospListNotifier=ValueNotifier([]);

//to add hospitals
Future<void> addHosp(HospModel value) async{
  final hospDB = await Hive.openBox<HospModel>('hosp_db');
  final id=await hospDB.add(value);
  final data = hospDB.get(id);
  await hospDB.put(id,HospModel(hosp: data!.hosp,id: id) );
  getHosp();

}

//to get hospitals
Future<void> getHosp() async{
  final hospDB = await Hive.openBox<HospModel>('hosp_db');
  hospListNotifier.value.clear();
  hospListNotifier.value.addAll(hospDB.values);
  hospListNotifier.notifyListeners();
 
}

//to delete hospitals
Future<void> deleteHosp(int id)async{
  final hospDB = await Hive.openBox<HospModel>('hosp_db');
   hospDB.delete(id);
    getHosp();

}

//to edit departments
Future<void> edithospital(int id, String updatedhospitalName) async {
  final hospDB = await Hive.openBox<HospModel>('hosp_db');
  final existingHospital = hospDB.values.firstWhere((hosp) => hosp.id == id);

  if (existingHospital == null) {
    print("no dept");
  }
  else{
    // Update the department's name
    existingHospital.hosp = updatedhospitalName;

    // Save the updated department back to Hive
    await hospDB.put(id, existingHospital);
    getHosp();
 

  }
}

//to search departments
Future<List<HospModel>> searchDepartments(String keyword) async {
  final hospDB = await Hive.openBox<HospModel>('dept_db');
  final hospitals = await hospDB.values.toList();

  // Use the `where` method to filter the data based on the search criteria
  final filteredHospitals = hospitals.where((hospital) {
    // Modify the condition based on your search criteria
    return hospital.hosp.contains(keyword);
  }).toList();

  return filteredHospitals;
}

