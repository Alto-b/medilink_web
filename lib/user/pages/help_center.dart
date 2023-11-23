// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medilink/styles/custom_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _subjectController=TextEditingController();
  final TextEditingController _bodyController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("HELP CENTER",style: appBarTitleStyle(),),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 5,),
            Text("Write to Us !"),
            Text(""),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _formKey,
                child: Column(
                children: [
            
                  TextFormField(
                    validator: validateEmpty,
                    controller:_subjectController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Subject"
                    ),
                  ),SizedBox(height: 20,),
            
                 TextFormField(
                  validator: validateEmpty,
                    controller:_bodyController,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Content"
                    ),
                  ),SizedBox(height: 20,),
            
                 ElevatedButton(onPressed: (){
                  launchEmail();
                 }, child: Text("Sent"))
            
                      
                  
                ],
              )),
            )
          ],
        ),
      ),
    );
    
  }
  

  //to validate cannot be empty
String? validateEmpty(String? value) {
  
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Cannot be empty';
  }
  return null; 
}

 

//to send email
Future<void> launchEmail() async {
  if (_formKey.currentState!.validate()) {
    final subject = _subjectController.text.trim();
    final body = _bodyController.text.trim();
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'nu3347145@gmail.com',
      query: 'body=$body&subject=$subject'
    );
    await launchUrl(emailLaunchUri);
  }
}


}