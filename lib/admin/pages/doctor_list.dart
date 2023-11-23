// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medilink/admin/db/doctor_functions.dart';
import 'package:medilink/admin/model/deptmodel.dart';
import 'package:medilink/admin/model/doctor_model.dart';
import 'package:medilink/admin/model/hospmodel.dart';
import 'package:medilink/styles/custom_widgets.dart';

class DoctorListPage extends StatefulWidget {
  const DoctorListPage({super.key});

  @override
  State<DoctorListPage> createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {

  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _qualificationController=TextEditingController();
  final TextEditingController _dobController=TextEditingController();
  final TextEditingController _dojController=TextEditingController();
  String? selectedGender;
  final List<String> genderOptions = ['Male', 'Female', 'Not Specified'];

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
    getDoctor();
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
//  getDoctor();
   

    return Scaffold(

      appBar: AppBar(
        title: Text("OUR DOCTORS",style: appBarTitleStyle(),),

      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              //Text("list of doctors"),
        //listener
                  Container(
                    //color: Colors.red,
                      height: 690,
                      child: ValueListenableBuilder(
                        valueListenable: doctorListNotifier,
                        builder: (BuildContext ctx, List<DoctorModel> doctorList,Widget? child) {
        
                        return ListView.separated(
                        itemBuilder:((context, index) {
                          final data=doctorList[index];
        
                          return Slidable(
                                  endActionPane: ActionPane(
                                    motion:DrawerMotion() ,
                                 children: [
                                  //delete
                                  SlidableAction(onPressed: (context) {
                                    deleteDoctor(data.id!);
                                   
                                  },
                                  icon:Icons.delete,
                                  backgroundColor: Color.fromARGB(255, 248, 3, 3),
                                  ),
                                  //edit
                                   SlidableAction(onPressed: (context) {
                                     _editSheet(context,data.id!, data.photo, data.name, data.gender, data.qualification, data.hospital, data.dob, data.doj, data.specialization);
                               
                                     },
                                  icon:Icons.edit,
                                  backgroundColor: Color.fromARGB(255, 3, 56, 248),
                                  ),
                                 ] ),
                               
                                          
            
                            child: Container(
                              child: ListTile(
                                onTap: () {
                                  
                                },
                                //tileColor: Colors.blue,
                                horizontalTitleGap: 10,
                                //contentPadding: EdgeInsets.all(5),
                                //leading: Text("${index+1}",),
                                leading: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: FileImage(File(data.photo)),
                                ),
                                title: Text("Dr.${data.name}",style:doctorListTitle(),),
                                contentPadding: EdgeInsets.all(5),      
                                
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Specialization: ${data.specialization}",style: doctorListSubtitle(),),
                                    Text("Qualification: ${data.qualification}",style: doctorListSubtitle(),),
                                    Text("Hospital: ${data.hospital}",style: doctorListSubtitle(),),
                                    Text("Join date: ${data.doj}",style: doctorListSubtitle(),),
                                    Text("Date of birth: ${data.dob}",style: doctorListSubtitle(),),
                                    

                                  ],
                                ),                    
                              ),
                            ),
                            
                          );
                        }) , 
                       separatorBuilder: ((context, index) {
                        return const Divider();
                        }), 
                      itemCount:doctorList.length);
                     }, ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

   //to edit section
  void _editSheet(BuildContext context,int id,String photo,String name,String gender,String qualification,String hosp,String dob,String doj,String dept){
    
     _selectedImage = File(photo);
     _nameController.text=name;
     selectedGender=gender;
     _qualificationController.text=qualification;
     selectedHospitalName=hosp;
     selectedDepartmentName=dept;
     _dobController.text=dob;
     _dojController.text=doj;


     
     
      showModalBottomSheet(context: context, builder:(context) {
        
        //_selectedImage=photo as File?;
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
                    child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: const Color.fromARGB(255, 18, 18, 18)),
                          //borderRadius: BorderRadius.circular(10)
                        ),
                        child: _selectedImage != null
                            ? Image.file(_selectedImage! as File, fit: BoxFit.fill,)
                            : Center(
                                child: Icon(Icons.add_a_photo))),
                  ),
                  Column(children: [
                    IconButton(
                        onPressed: () {
                          _pickImage();
                        },
                        icon: Icon(Icons.photo_library_outlined),tooltip: "select from gallery",),
                    IconButton(
                        onPressed: () {
                          _photoImage();
                        },
                        icon: Icon(Icons.camera_alt_outlined),tooltip: "open camera")
                  ])
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
                     
              SizedBox(height: 20,),
          
        
        //submit button
                  ElevatedButton(onPressed: (){
                    // submit();
                  editDoctor(id,_selectedImage!.path, _nameController.text,gender, _qualificationController.text,selectedHospitalName!, _dobController.text, _dojController.text, selectedDepartmentName!);
                  showSnackBarSuccess(context, "Details updated successfully!");
                  Navigator.pop(context);
                  }, child: Text("Update"))
          
                
          
                    ],
          
                )
                )
              ],
            ),
        ),
      );
       }, );
  }

// Future<void> submit() async{
//   final imagepath=_selectedImage!.path;
//   final String name=_nameController.text.trim();
//   final String gender=selectedGender ?? "";
//   final String qualification=_qualificationController.text.trim();
//   final String dob=_dobController.text.trim();
//   final String doj=_dojController.text.trim();
//   final String hospital=selectedHospitalName!;
//   final String specialization=selectedDepartmentName!;


//   if(_formKey.currentState!.validate()){
//     final _doctor=DoctorModel(name: name, gender: gender, qualification: qualification, dob: dob, doj: doj, hospital: hospital, specialization: specialization,photo:imagepath);
//     //addDoctor(_doctor);
//     editDoctor(id, updatedPhoto, updatedName, updatedGender, updatedQualification, updatedHospital, updatedDOB, updatedDOJ, updatedDept)
//     showSnackBarSuccess(context, "Details added successfully!");
//     Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorListPage(),));
//   }
//   else{
//       showSnackBarFailed(context, "Couldn't add details!");
//   }
// }

//code for snackbar failed  
// void showSnackBarFailed(BuildContext context, String message) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(message),
//       duration: Duration(seconds: 3), 
//     ),
//   );
// }

//code for snackbar success  
void showSnackBarSuccess(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3), 
    ),
  );
}


//IMAGE THROUGH CAMERA
Future<void> _photoImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }
  //IMAGE FROM PHOTOS
Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }
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



}