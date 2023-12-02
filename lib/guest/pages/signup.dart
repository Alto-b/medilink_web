// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medilink/admin/pages/dashboard.dart';
import 'package:medilink/guest/db/user_functions.dart';
import 'package:medilink/guest/model/usermodel.dart';
import 'package:medilink/guest/pages/login.dart';
import 'package:email_auth/email_auth.dart';
import 'package:medilink/main.dart';
import 'package:medilink/user/mainpage.dart';
import 'package:medilink/user/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _dobController=TextEditingController();
  String? selectedGender;
  final List<String> genderOptions = ['Male', 'Female', 'Not to specify'];
  //final TextEditingController _genderController=TextEditingController();
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final TextEditingController _cpasswordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

       

    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            SizedBox(height: 50,),
            Image.asset('lib/assets/medilink.png',width: 200,),
            SizedBox(height: 30,),
            Align(
              child: Container(
                width: 500,
                child: Form(
                  key: _formKey,
                  child: Column(
                  children: [
                  
                    //full name
                    TextFormField(
                      validator: validateFullName,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: "Full Name",
                        ),
                      
                    ),
                  
                    SizedBox(height: 20,),
                  
                    //date of birth
                    TextFormField(
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "select date of birth";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _dobController,
                      decoration: InputDecoration(
                        //label: Text("dob"),
                        hintText: "Date Of Birth"
                      ),
                      readOnly: true,
                      onTap: (){
                        //print("date picker");
                        _selectDate(context);
                         },
                    ),
                  
                    SizedBox(height: 20,),
                  
                    //gender selection
                    DropdownButtonFormField(
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "select a gender";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                       ),),
                  
                       SizedBox(height: 20,),
                  
                       //email 
                    TextFormField(
                      validator:validateEmail ,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Email"
                      ),
                    ),
                   SizedBox(height: 30,),
                   //password
                   TextFormField(
                      validator:validatepassword ,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: "Password"
                      ),
                    ),
                     SizedBox(height: 30,),
                   //confirm password
                   TextFormField(
                      validator: validatecpassword ,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      controller: _cpasswordController,
                      decoration: InputDecoration(
                        hintText: "Confirm Password"
                      ),
                    ),
                    SizedBox(height: 20,),
              
                   ElevatedButton(onPressed: (){
                       //addUserbutton();
                       userCheck(_emailController.text);
                    },
                     style:ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 9, 212, 114),
                      
                     ),
                     child: Text("Proceed",style: TextStyle(
                      color: Colors.white
                     ),)
                     ),
              
                  SizedBox(height: 15,),
              
                  //to login
                  TextButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                  }, child: Text("Already has an account ?")),
                  
                  ],
                )),
              ),
            )
          ],
          
        ),
      ),
    ),

  



    );
  }

//to select date
  Future<void> _selectDate(BuildContext context) async {
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

//to validate password
String? validatepassword(String? value){
  final trimmedValue = value?.trim();

  if(trimmedValue == null || trimmedValue.isEmpty){
    return 'Cannot be empty';
  }
  return null;
}

//to validate conform password
String? validatecpassword(String? value){
  final trimmedValue = value?.trim();

  if(trimmedValue == null || trimmedValue.isEmpty){
    return 'Cannot be empty';
  }
  if(trimmedValue!=_passwordController.text){
    return 'Password must watch';
  }
  return null;
}

//to check if new user
void userCheck(String email)async{
  await Hive.openBox<UserModel>('user_db');
  final userDB=Hive.box<UserModel>('user_db');
  final userExists=userDB.values.any((user) => user.email == email);

  if(userExists){
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: Text("Error"),
          content: Text("User already exists"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Ok"))
          ],
        );
      });
  }
  else{
    addUserbutton();
  }

}



//to add user
    Future<void> addUserbutton() async{
      final String fullName = _nameController.text.trim();
    final String dateOfBirth = _dobController.text.trim();
    final String gender = selectedGender ?? ""; 
    final String email = _emailController.text.trim();
    final String pass = _passwordController.text.trim();
    final String cpass = _cpasswordController.text.trim();

      if(_formKey.currentState!.validate() && _passwordController.text==_cpasswordController.text){
        //print('empty');
        //print('$_dept');
      final _user=UserModel(fullname: fullName, dob: dateOfBirth, gender: gender, email: email, password: pass);
      addUser(_user);
      //Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => LoginPage(),));
      login(_emailController.text, _passwordController.text, context);
      
       
      }
      else{
        showSnackBar(context, 'User registration failed!');
          _nameController.clear();
                   _dobController.clear();
                   _emailController.clear();
                   _passwordController.clear();
                   _cpasswordController.clear();
      }
    }

//code for snackbar    
void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3), 
    ),
  );
}

//to login
void login(String email,String password,BuildContext context) async{

final userDB=await Hive.openBox<UserModel>('user_db');

UserModel? user;
for(var i=0;i<userDB.length;i++){
  final currentUser = userDB.getAt(i);

  if(currentUser?.email == email && currentUser?.password == password){
    user=currentUser;
    break;
  }
}

if(user != null){
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool(SAVE_KEY_NAME, true);
  await saveUserEmail(email);
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ResponsiveNavbar(),));

}
else{
  showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
       // title : const Text("error"),
        content: const Text("invalid email or password"),
        actions: [
          TextButton(onPressed:() => Navigator.pop(context), 
          child: Text("Ok"))
        ],
      );
    });
}
}

//to set current user
Future<void> saveUserEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentUser', email);
  }

}
