// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:medilink/admin/db/doctor_functions.dart';
import 'package:medilink/admin/model/deptmodel.dart';
import 'package:medilink/admin/model/doctor_model.dart';
import 'package:medilink/admin/model/hospmodel.dart';
import 'package:medilink/admin/pages/doctor_list.dart';
import 'package:medilink/styles/custom_widgets.dart';
import 'package:medilink/user/pages/specializations.dart';

class AddDoctor extends StatefulWidget {
  const AddDoctor({super.key});

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _qualificationController=TextEditingController();
  final TextEditingController _dobController=TextEditingController();
  final TextEditingController _dojController=TextEditingController();
  String? selectedGender;
  final List<String> genderOptions = ['Male', 'Female', 'Not Specified'];

    bool imageAvailable = false;
  late Uint8List imageFile;

 late Box<DepartmentModel> deptBox;
  late Box<HospModel> hospBox;
  List<DepartmentModel> departments = [];
  List<HospModel> hospitals = [];
  String? selectedDepartmentName;
  String? selectedHospitalName;

  @override
  void initState() {
    super.initState();
    openHiveBoxes();
  }
Future<void> openHiveBoxes() async {
    deptBox = await Hive.openBox<DepartmentModel>('dept_db');
    hospBox = await Hive.openBox<HospModel>('hosp_db');
    updateLists();
  }
void updateLists() {
    setState(() {
      departments = deptBox.values.toList();
      hospitals = hospBox.values.toList();

      if (!departments.any((dept) => dept.dept == selectedDepartmentName)) {
        selectedDepartmentName = null;
      }

      if (!hospitals.any((hosp) => hosp.hosp == selectedHospitalName)) {
        selectedHospitalName = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("ADD DOCTORS",style: appBarTitleStyle(),) ,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Align(
            child: Container(
              width: 500,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                    
                        //add photo
                    
                         Row(
                          children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child:GestureDetector(
                       onTap: () async {
                        final image = await ImagePickerWeb.getImageAsBytes();
              
                        setState(() {
                          imageFile = image!;
                          imageAvailable=true;
                        });
                      },
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[100]
                        ),
                        child: imageAvailable?Image.memory(imageFile) :Icon(Icons.add_a_photo), 
                      ),
                    )
                    ),
                   
                  ]),SizedBox(height: 20,),
                  
            //full name
                  TextFormField(
                    controller: _nameController,
                    validator: validateFullName,
                    decoration: InputDecoration(
                      hintText: "Full Name",
                    ),
                  ),SizedBox(height: 20,),
            
            //gender selection
                    DropdownButtonFormField(
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "select a gender";
                        }
                        return null;
                      },
                      value: selectedGender,
                      items:genderOptions.map((String gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender)
                          );
                      }).toList() ,
                       onChanged: (String? newValue){
                        setState(() {
                          selectedGender=newValue!;
                        });
                       },
                       decoration: InputDecoration(
                        hintText: "Gender"
                       ),),SizedBox(height: 20,),
                  
            //qualification
                  TextFormField(
                    controller: _qualificationController,
                    validator: validateQualification,
                    decoration: InputDecoration(
                      hintText: "Qualification",
                    ),
                  ),SizedBox(height: 20,),
                  
            //date of birth
                 TextFormField(
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "select date of birth";
                          }
                          return null;
                        },
                        controller: _dobController,
                        decoration: InputDecoration(
                          //label: Text("dob"),
                          hintText: "Date Of Birth"
                        ),
                        readOnly: true,
                        onTap: (){
                          //print("date picker");
                          _selectDob(context);
                           },
                      ),SizedBox(height: 20,),
                  
            //date of join
                 TextFormField(
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "select date of join";
                          }
                          return null;
                        },
                        controller: _dojController,
                        decoration: InputDecoration(
                          //label: Text("dob"),
                          hintText: "Date Of Join"
                        ),
                        readOnly: true,
                        onTap: (){
                          //print("date picker");
                          _selectDoj(context);
                           },
                      ),SizedBox(height: 20,),
            //selecet hospital
                     DropdownButtonFormField<String>(
                      validator: (value){
                        if(value == null ){
                          return "select Hospital";
                        }
                        return null;
                      },
                      value: selectedHospitalName,
                       items: hospitals.map((HospModel hospitals) {
                return DropdownMenuItem<String>(
                  value: hospitals.hosp,
                  child: Text(hospitals.hosp),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedHospitalName = newValue;
                });
              },
              decoration: InputDecoration(
                        hintText: "Hospital"
                       ),
                    ),
                       
                SizedBox(height: 20,),
            
            //department selection
                    DropdownButtonFormField<String>(
                      validator: (value){
                        if(value == null ){
                          return "select Specialization";
                        }
                        return null;
                      },
                      value: selectedDepartmentName,
                       items: departments.map((DepartmentModel department) {
                return DropdownMenuItem<String>(
                  value: department.dept,
                  child: Text(department.dept),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedDepartmentName = newValue;
                });
              },
              decoration: InputDecoration(
                        hintText: "Specialization"
                       ),
                    ),
                       
                SizedBox(height: 30,),
              
            
            //submit button
                    ElevatedButton(onPressed: (){
                      submit();
                    }, child: Text("ADD DOCTOR")),


                    SizedBox(height: 30,)
                    

                  
                    
                      ],
                    
                  )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
//to validate full name
String? validateFullName(String? value) {
  
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Full Name is required';
  }

  final RegExp nameRegExp = RegExp(r'^[a-zA-Z ]+$');

  if (!nameRegExp.hasMatch(trimmedValue)) {
    return 'Full Name can only contain letters and spaces';
  }

  return null; 
}

//to validate qualification
String? validateQualification(String? value) {
  
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Qualification is required';
  }
  return null; 
}
  
//IMAGE THROUGH CAMERA
// Future<void> _photoImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.camera);

//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage = File(pickedImage.path);
//       });
//     }
//   }

//IMAGE FROM PHOTOS
// Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage = File(pickedImage.path);
//       });
//     }
//   }

//to select dob
 Future<void> _selectDob(BuildContext context) async {
    //print("dob clicked");
  DateTime selectedDate = DateTime.now(); // Initialize with the current date.

  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime(2000),
    firstDate: DateTime(1900), // Start date for selection
    lastDate: DateTime(2023), // End date for selection
  );

  if (picked != null && picked != selectedDate) {
    // Update the selected date
    setState(() {
      selectedDate = picked;
      _dobController.text = selectedDate.toLocal().toString().split(' ')[0];
    });
  }
}

//to select doj
 Future<void> _selectDoj(BuildContext context) async {
    //print("dob clicked");
  DateTime selectedDate = DateTime.now(); // Initialize with the current date.

  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime(2000),
    firstDate: DateTime(1900), // Start date for selection
    lastDate: DateTime(2023), // End date for selection
  );

  if (picked != null && picked != selectedDate) {
    // Update the selected date
    setState(() {
      selectedDate = picked;
      _dojController.text = selectedDate.toLocal().toString().split(' ')[0];
    });
  }
}

Future<void> submit() async{
  final imagepath=imageFile;
  final String name=_nameController.text.trim();
  final String gender=selectedGender ?? "";
  final String qualification=_qualificationController.text.trim();
  final String dob=_dobController.text.trim();
  final String doj=_dojController.text.trim();
  final String hospital=selectedHospitalName!;
  final String specialization=selectedDepartmentName!;


  if(_formKey.currentState!.validate()){
    final _doctor=DoctorModel(name: name, gender: gender, qualification: qualification, dob: dob, doj: doj, hospital: hospital, specialization: specialization,photo:imagepath);
    addDoctor(_doctor);
    showSnackBarSuccess(context, "Details added successfully!");
    Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorListPage(),));
  }
  else{
      showSnackBarFailed(context, "Couldn't add details!");
  }
  

}

//code for snackbar success  
void showSnackBarFailed(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3), 
    ),
  );
}

//code for snackbar success  
void showSnackBarSuccess(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3), 
    ),
  );
}

}


