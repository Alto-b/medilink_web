// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medilink/admin/db/telemedicine_functions.dart';
import 'package:medilink/admin/model/telemedicine_model.dart';
import 'package:medilink/styles/custom_widgets.dart';
import 'package:medilink/user/mainpage.dart';
import 'package:navigator/navigator.dart' as navigator;


class TelemedicinePage extends StatefulWidget {
  const TelemedicinePage({super.key});

  @override
  State<TelemedicinePage> createState() => _TelemedicinePageState();
}

class _TelemedicinePageState extends State<TelemedicinePage> {

  bool showError = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final  TextEditingController _nameController = TextEditingController();
  final  TextEditingController _addressController = TextEditingController();
  final  TextEditingController _emailController = TextEditingController();
  final  TextEditingController _mobileController = TextEditingController();
  final  TextEditingController _symptomController = TextEditingController();
  final TextEditingController _medicineController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TELEMEDICINE",style: appBarTitleStyle(),)),
      //backgroundColor: Colors.amber,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Align(
                child: Container(
                 decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)
                 ),
                  width: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key:_formKey,
                      child: Column(
                      children: [
                        
                        //name textfield
                        TextFormField(
                          controller: _nameController,
                          validator: validateFullName,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            hintText: "Full Name",
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35)
                            )
                          ),
                                            
                         ),
                        
                         SizedBox(height: 20,),
                        
                         //address textfield
                        TextFormField(
                          controller: _addressController,
                          validator: validateAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            hintText: "Address",
                            prefixIcon: Icon(Icons.home),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35)
                        
                            )
                          ),
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                                            
                         ),
                         SizedBox(height: 20,),
                        
                         //email textfield
                        TextFormField(
                          controller: _emailController,
                          validator: validateEmail,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35)
                            )
                          ),
                                            
                         ),SizedBox(height: 20,),
                        
                         //mobile textfield
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _mobileController,
                          validator: validateNumber,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          //errorText: showError ? "Error message" : null,
                          decoration: InputDecoration(
                            hintText: "Mobile",
                            prefixIcon: Icon(Icons.call),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35)
                            )
                          ),                  
                         ),SizedBox(height: 20,),
                        
                         //symptoms textfield
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          controller: _symptomController,
                          validator: validateEmpty,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            hintText: "Syptoms ....",
                            prefixIcon: Icon(Icons.question_mark_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35)
                            )
                          ),     
                          maxLines: null,
                                        
                         ),SizedBox(height: 20,),
                                  
                         //Medicine looking for
                         TextFormField(
                          keyboardType: TextInputType.multiline,
                          controller: _medicineController,
                          validator: validateEmpty,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            hintText: "Medicines looking for..",
                            prefixIcon: Icon(Icons.medication_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35)
                            )
                          ),
                          
                         ), SizedBox(height: 20,),
                                  
                         ElevatedButton(onPressed: (){
                          addTelemedicineButton();
                         }, child: Text("Submit"))
                        
                         
                      ],
                    )),
                  ),
                ),
              ),
            )
          ],
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

//to validate address
String? validateAddress(String? value) {
  
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Address is required';
  }
  return null; 
}

//to validate cannot be empty
String? validateEmpty(String? value) {
  
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Cannot be empty';
  }
  return null; 
}


//to validate email
String? validateEmail(String? value) {
  
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Email is required';
  }

  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
  );

  if (!emailRegExp.hasMatch(trimmedValue)) {
    return 'Invalid email address';
  }

  return null; 
}

//to validate number
String? validateNumber(String? value) {
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Mobile number is required';
  }

  final RegExp numberRegExp = RegExp(r'^[0-9]{10}$');

  if (!numberRegExp.hasMatch(trimmedValue)) {
    return 'Mobile number must be exactly 10 digits and contain only numbers';
  }

  return null;
}

//submit form
Future<void> addTelemedicineButton()async{

  final String name=_nameController.text.trim();
  final String address=_addressController.text.trim();
  final String email=_emailController.text.trim();
  final String mobile=_mobileController.text.trim() ;
  final String symptoms=_symptomController.text.trim();
  final String medicine=_medicineController.text.trim();
  final DateTime date=DateTime.now();


  if(_formKey.currentState!.validate()){
    final telemedicine=TelemedicineModel(name: name, address: address, email: email, mobile: mobile, symptoms: symptoms, medicine: medicine,date: date);
    addTelemedicine(telemedicine);
    showSnackBarSuccess(context, 'We will contact you soon');
  }
  else{
    setState(() {
      showError = true;
    });

    Timer(Duration(seconds: 5), () {
      // Hide the error message after 5 seconds
      setState(() {
        showError = false;
      });
    });

    showSnackBarFailed(context, "Enquiry couldn't be placed. Try again ");
  }
}


//code for success snackbar
void showSnackBarSuccess(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text(message),
      duration: Duration(seconds: 3), 
    ),
  );
  Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
}
//code for failed snackbar
void showSnackBarFailed(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red[400],
      content: Text(message),
      duration: Duration(seconds: 3), 
    ),
  );
//   setState(() {
//      Future.delayed(const Duration(seconds: 3), () {
//   Navigator.push(context, MaterialPageRoute(builder: (context) => TelemedicinePage(),));
 
// });

//   });
}

}