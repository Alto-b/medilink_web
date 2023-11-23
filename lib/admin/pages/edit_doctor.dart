// import 'package:flutter/material.dart';
// import 'package:medilink/styles/custom_widgets.dart';

// class EditDoctorPage extends StatefulWidget {
//   const EditDoctorPage({super.key});

//   @override
//   State<EditDoctorPage> createState() => _EditDoctorPageState();
// }

// class _EditDoctorPageState extends State<EditDoctorPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       appBar: AppBar(
//         title: Text("EDIT PROFILE",style: appBarTitleStyle()),
//       ),

//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(25.0),
//           child: Column(
//             children: [
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
        
//                     //add photo
        
//                      Row(
//                       children: [
//                 Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Container(
//                       height: 150,
//                       width: 150,
//                       decoration: BoxDecoration(
//                         border: Border.all(width: 2, color: const Color.fromARGB(255, 18, 18, 18)),
//                         //borderRadius: BorderRadius.circular(10)
//                       ),
//                       child: _selectedImage != null
//                           ? Image.file(_selectedImage! as File, fit: BoxFit.fill,)
//                           : Center(
//                               child: Icon(Icons.add_a_photo))),
//                 ),
//                 Column(children: [
//                   IconButton(
//                       onPressed: () {
//                         _pickImage();
//                       },
//                       icon: Icon(Icons.photo_library_outlined),tooltip: "select from gallery",),
//                   IconButton(
//                       onPressed: () {
//                         _photoImage();
//                       },
//                       icon: Icon(Icons.camera_alt_outlined),tooltip: "open camera")
//                 ])
//               ]),SizedBox(height: 20,),
      
// //full name
//               TextFormField(
//                 controller: _nameController,
//                 validator: validateFullName,
//                 decoration: InputDecoration(
//                   hintText: "Full Name",
//                 ),
//               ),SizedBox(height: 20,),

// //gender selection
//                 DropdownButtonFormField(
//                   validator: (value){
//                     if(value == null || value.isEmpty){
//                       return "select a gender";
//                     }
//                     return null;
//                   },
//                   value: selectedGender,
//                   items:genderOptions.map((String gender) {
//                     return DropdownMenuItem<String>(
//                       value: gender,
//                       child: Text(gender)
//                       );
//                   }).toList() ,
//                    onChanged: (String? newValue){
//                     setState(() {
//                       selectedGender=newValue!;
//                     });
//                    },
//                    decoration: InputDecoration(
//                     hintText: "Gender"
//                    ),),SizedBox(height: 20,),
      
// //qualification
//               TextFormField(
//                 controller: _qualificationController,
//                 validator: validateQualification,
//                 decoration: InputDecoration(
//                   hintText: "Qualification",
//                 ),
//               ),SizedBox(height: 20,),
      
// //date of birth
//              TextFormField(
//                     validator: (value){
//                       if(value == null || value.isEmpty){
//                         return "select date of birth";
//                       }
//                       return null;
//                     },
//                     controller: _dobController,
//                     decoration: InputDecoration(
//                       //label: Text("dob"),
//                       hintText: "Date Of Birth"
//                     ),
//                     readOnly: true,
//                     onTap: (){
//                       //print("date picker");
//                       _selectDob(context);
//                        },
//                   ),SizedBox(height: 20,),
      
// //date of join
//              TextFormField(
//                     validator: (value){
//                       if(value == null || value.isEmpty){
//                         return "select date of join";
//                       }
//                       return null;
//                     },
//                     controller: _dojController,
//                     decoration: InputDecoration(
//                       //label: Text("dob"),
//                       hintText: "Date Of Join"
//                     ),
//                     readOnly: true,
//                     onTap: (){
//                       //print("date picker");
//                       _selectDoj(context);
//                        },
//                   ),SizedBox(height: 20,),

// //hospital selection
//                 DropdownButtonFormField(
//                   validator: (value){
//                     if(value == null || value.isEmpty){
//                       return "select Hospital";
//                     }
//                     return null;
//                   },
//                   value: selectedHospital,
//                   items:genderOptions.map((String gender) {
//                     return DropdownMenuItem<String>(
//                       value: gender,
//                       child: Text(gender)
//                       );
//                   }).toList() ,
//                    onChanged: (String? newValue){
//                     setState(() {
//                       selectedHospital=newValue!;
//                     });
//                    },
//                    decoration: InputDecoration(
//                     hintText: "Hospital"
//                    ),),SizedBox(height: 20,),

// //department selection
//                 DropdownButtonFormField(
//                   validator: (value){
//                     if(value == null ){
//                       return "select Specialization";
//                     }
//                     return null;
//                   },
//                   value: selectedSpecialization,
//                   items:SpecializationOptions.map((String gender) {
//                     return DropdownMenuItem<String>(
//                       value: gender,
//                       child: Text(gender)
//                       );
//                   }).toList() ,
//                    onChanged: (String? newValue){
//                     setState(() {
//                       selectedSpecialization=newValue!;
//                     });
//                    },
//                    decoration: InputDecoration(
//                     hintText: "Specialization"
//                    ),),SizedBox(height: 20,),

// //submit button
//                 ElevatedButton(onPressed: (){
//                   submit();
//                 }, child: Text("ADD DOCTOR"))
        
              
        
//                   ],
        
//               ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }