// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink/admin/db/doctor_functions.dart';
import 'package:medilink/admin/model/doctor_model.dart';
import 'package:medilink/styles/custom_widgets.dart';
import 'package:medilink/user/pages/doctor_search.dart';

class DoctorViewPage extends StatefulWidget {
  const DoctorViewPage({super.key});

  @override
  State<DoctorViewPage> createState() => _DoctorViewPageState();
}

class _DoctorViewPageState extends State<DoctorViewPage> {

    @override
  void initState(){
    super.initState();
     getDoctor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("OUR DOCTORS",style: appBarTitleStyle(),),
        actions: [       
            IconButton(onPressed: (){
              showSearch(
                context: context, 
                delegate: DoctorSearchDelegate());
            }, icon: Icon(Icons.search))
        ],
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
                      height: 680,
                      child: ValueListenableBuilder(
                        valueListenable: doctorListNotifier,
                        builder: (BuildContext ctx, List<DoctorModel> doctorList,Widget? child) {
        
                        return ListView.separated(
                        itemBuilder:((context, index) {
                          final data=doctorList[index];
        
                          return Container(
                            child: ListTile(
                              onTap: () {
                                //_detailSheet(context,data.id!,data.dob,data.doj,data.gender,data.hospital,data.name,data.photo,data.qualification,data.specialization);
                              _detailSheet(context, data.id!, data.name,data.dob,data.doj, data.gender, data.photo, data.qualification, data.qualification,data.hospital);
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

                                ],
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

void _detailSheet(BuildContext context,int id,String name,String dob,String doj,String gender,String photo,String qualification,String specialization,String hospital){

    showModalBottomSheet(context: context, builder: (context){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          height: 500,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                CircleAvatar(
                  backgroundImage: FileImage(File(photo)),
                  radius: 80,
                ),SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Dr.$name is a qualified physician with expertise in $qualification. Born on $dob, Dr.$name joined the medical profession on $doj. Currently affiliated with $hospital, Dr.$name specializes in $specialization.",
                  style: GoogleFonts.dmSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1.4
      
                    
      
                  ),textAlign: TextAlign.justify,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
}

}