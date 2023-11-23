

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medilink/admin/model/doctor_model.dart';

ValueNotifier<List<DoctorModel>> doctorListNotifier=ValueNotifier([]);

//to add doctors
Future<void> addDoctor(DoctorModel value) async{
  final doctorDB = await Hive.openBox<DoctorModel>('doctor_db');
  final id=await doctorDB.add(value);
  final data = doctorDB.get(id);
  await doctorDB.put(id,DoctorModel(name: data!.name, gender: data!.gender, qualification:data!.qualification, dob: data!.dob, doj: data!.doj, hospital:data!.hospital, specialization: data!.specialization,photo: data!.photo,id: id) );
  print(doctorDB.values);
}

//to get doctors
Future<void> getDoctor() async {
  final doctorDB = await Hive.openBox<DoctorModel>('doctor_db');
  doctorListNotifier.value.clear();
  doctorListNotifier.value.addAll(doctorDB.values);

  // Sort the list of doctors in ascending order of names
  doctorListNotifier.value.sort((a, b) => a.name.compareTo(b.name));

  doctorListNotifier.notifyListeners();
}

//to delete doctors
Future<void> deleteDoctor(int id) async{
  final docDB = await Hive.openBox<DoctorModel>('doctor_db');
  await docDB.delete(id);
  getDoctor();
}

//to get doctor count
Future<int> doctorStats() async{
  final docDB = await Hive.openBox<DoctorModel>('doctor_db');
  final docCount=docDB.length;
  return docCount;
}

Future<void> editDoctor(
  int id, 
  String updatedPhoto,
  String updatedName,
  String updatedGender,
  String updatedQualification,
  String updatedHospital,
  String updatedDOB,
  String updatedDOJ,
  String updatedDept
  
  ) async {
  final deptBox = await Hive.openBox<DoctorModel>('doctor_db');
  final existingDoctor = deptBox.values.firstWhere((doc) => doc.id == id);

  if (existingDoctor == null) {
    //print("no doc");
  }
  else{
    // Update 
    existingDoctor.photo=updatedPhoto;
    existingDoctor.name = updatedName;
    existingDoctor.gender=updatedGender;
    existingDoctor.qualification=updatedQualification;
    existingDoctor.hospital=updatedHospital;
    existingDoctor.dob=updatedDOB;
    existingDoctor.doj=updatedDOJ;
    existingDoctor.specialization=updatedDept;

    // Save the updated 
    await deptBox.put(id, existingDoctor);
   getDoctor();
 

  }
}