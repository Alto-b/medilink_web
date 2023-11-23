// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medilink/admin/db/appointment_functions.dart';
import 'package:medilink/admin/model/appointment_model.dart';
import 'package:medilink/guest/model/usermodel.dart';
import 'package:medilink/styles/custom_widgets.dart';
import 'package:medilink/user/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({super.key});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {

  String? selectedTitle; 
  final List<String> titles = ['Mr.', 'Mrs.','Ms','Baby','Baby Of',];
  String? selectedGender;
  final List<String> genderOptions = ['Male', 'Female', 'Others'];
  String? selectedMarital;
  final List<String> maritalOptions = ['Single', 'Married', 'Divorced','Widowed','Unknown/Not to specify'];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _genderController=TextEditingController();
  final TextEditingController _dobController=TextEditingController();
  final TextEditingController _maritalController=TextEditingController();
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _mobileController=TextEditingController();
  final TextEditingController _addressController=TextEditingController();

    String userEmail = ''; 
  UserModel? currentUser;
  
   int age=0;

   

   @override
  void initState() {
    super.initState();
    // Call the getUser function when the page is initialized
    getUser();    
  }

  Future<void> getUser() async {
    // Retrieve currentUser email from shared preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   
   //if(currentUser != null)
    userEmail = prefs.getString('currentUser') ?? '';
    // check the user in Hive using the email
    final userBox = await Hive.openBox<UserModel>('user_db');
    currentUser = userBox.values.firstWhere(
      (user) => user.email == userEmail,
      //orElse: () => null,
    );
    calculateAge();
    setState(() {}); 
  }
void calculateAge() {
    if (currentUser != null) {
      String dobString = currentUser!.dob ?? '';
      DateTime dob = DateTime.parse(dobString);
      DateTime currentDate = DateTime.now();
      Duration difference = currentDate.difference(dob);
      age = (difference.inDays / 365).floor();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BOOK APPOINTMENTS",style: appBarTitleStyle(),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
      //               Row(
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: [
      // // Title Dropdown
      //                   DropdownButtonFormField<String>(
      //                     hint:Text("Title"),
      //                     value: selectedTitle,
      //                     onChanged: (String? newValue) {
      //                       setState(() {
      //                         selectedTitle = newValue;
      //                       });
      //                     },
      //                     items: titles.map((String title) {
      //                       return DropdownMenuItem<String>(
      //                         value: title,
      //                         child: Text(title), 
      //                       );
      //                     }).toList(),
      //                   ),SizedBox(width: 20,),
      
      // //Full Name
      //               Expanded(
      //                 child: TextFormField(
      //                   controller: _nameController,
      //                   validator: validateFullName,
      //                   decoration: InputDecoration(
      //                     hintText: "Full Name",
      //                   ),
      //                 ),
      //               ),
      //                 ],
      //               ),SizedBox(height: 20,),

       DropdownButtonFormField<String>(
        validator: (value){
                      if(value == null || value.isEmpty){
                        return "select a gender";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.title),
        ),
         hint:Text("Title"),
         value: selectedTitle,
         onChanged: (String? newValue) {
           setState(() {
             selectedTitle = newValue;
           });
         },
         items: titles.map((String title) {
           return DropdownMenuItem<String>(
             value: title,
             child: Text(title), 
           );
         }).toList(),
       ),
       SizedBox(height: 20,),
      
      //Full Name
                    TextFormField(
       controller: _nameController,
       validator: validateFullName,
       autovalidateMode: AutovalidateMode.onUserInteraction,
       decoration: InputDecoration(
        prefixIcon: Icon(Icons.abc),
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
                      //prefixIcon: FaIcon(FontAwesomeIcons.marsAndVenus,color: Colors.grey,),
                      prefixIcon: Icon(Icons.arrow_right_rounded,color: Colors.grey,),
                      hintText: "Gender"
                     ),),SizedBox(height: 20,),
      
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
                      prefixIcon: Icon(Icons.calendar_month,color: Colors.grey,),
                      hintText: "Date Of Birth"
                    ),
                    readOnly: true,
                    onTap: (){
                      //print("date picker");
                      _selectDate(context);
                       },
                  ),SizedBox(height: 20,),
      
      //marital status drop down
                  DropdownButtonFormField(
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "select a status";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    value: selectedMarital,
                    items:maritalOptions.map((String marital) {
                      return DropdownMenuItem<String>(
                        value: marital,
                        child: Text(marital)
                        );
                    }).toList() ,
                     onChanged: (String? newValue){
                      setState(() {
                        selectedMarital=newValue!;
                      });
                     },
                     decoration: InputDecoration(
                      prefixIcon: Icon(Icons.arrow_right_rounded,color: Colors.grey,),
                      hintText: "Marital Status"
                     ),),SizedBox(height: 20,),
      
      //email 
                  TextFormField(
                    validator:validateEmail ,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email,color: Colors.grey,),
                      hintText: "Email"
                    ),
                  ),SizedBox(height: 20,),
      //Mobile Number
                  TextFormField(
                    validator:validateNumber ,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    controller: _mobileController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.call,color: Colors.grey,),
                      hintText: "Mobile"
                    ),
                  ),SizedBox(height: 20,),
      
      //address textfield
                    TextFormField(
                      controller: _addressController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: validateEmpty,
                      decoration: InputDecoration(
                        hintText: "Address",
                        prefixIcon: Icon(Icons.home,color: Colors.grey,),
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                                        
                     ),
                     SizedBox(height: 30,),

                     //submit button
                     ElevatedButton(onPressed: (){
                      addAppointmentButton();
                     }, child: Text("Submit"))
      
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


 
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

//to validate cannot be empty
String? validateEmpty(String? value) {
  
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Cannot be empty';
  }
  return null; 
}


//submit form
Future<void> addAppointmentButton()async{

  final String title=selectedTitle ?? "";
  final String name=_nameController.text.trim();
  final String gender = selectedGender ?? ""; 
  final String dob=_dobController.text.trim();
  final String marital=selectedMarital ?? ""; 
  final String email=_emailController.text.trim();
  final String mobile=_mobileController.text.trim();
  final String address=_addressController.text.trim();
  final DateTime date=DateTime.now();
  final String user=currentUser!.fullname;
  


  if(_formKey.currentState!.validate()){
    //print("validated");
    final appointment=AppointmentModel(name: name, gender: gender, dob: dob, marital: marital, email: email, mobile: mobile, address: address,title:title,date: date,user: user) ;
    addAppointment(appointment);
    showSnackBarSuccess(context, 'We will contact you soon');
    Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
  }
  else{
    setState(() {
      //showError = true;
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
