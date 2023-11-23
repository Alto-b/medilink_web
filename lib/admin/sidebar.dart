// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medilink/admin/pages/dash_web.dart';
import 'package:medilink/admin/pages/dashboard.dart';
import 'package:medilink/admin/pages/department.dart';
import 'package:medilink/admin/pages/doctor.dart';
import 'package:medilink/admin/pages/doctor_list.dart';
import 'package:medilink/admin/pages/hospital.dart';
//import 'package:medilink/admin/pages/new_department.dart';
import 'package:medilink/admin/pages/statistics.dart';
import 'package:medilink/admin/pages/telemedicine_view.dart';
import 'package:medilink/user/pages/feedback.dart';
import 'package:medilink/user/pages/telemedicine.dart';
import 'package:side_navigation/side_navigation.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  List<Widget> views = const [
    Center(
      child: Text('Dashboard'),
    ),
    Center(
      child: Text('Account'),
    ),
    Center(
      child: Text('Settings'),
    ),
  ];
  int selectedIndex = 0;
   List screen = const[
    DashWeb(),
    StatisticsPage(),
    DepartmentPage(),
    HospitalPage(),
    AddDoctor(),
    DoctorListPage(),
    TelemedicineViewPage(),
    FeedbackPage(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideNavigationBar(
            header: SideNavigationBarHeader(
              image: CircleAvatar(
                child: Icon(Icons.admin_panel_settings_outlined),
              ),
              title: Text('Welcome',),
              subtitle: Text('ADMIN')
            ),
            footer: SideNavigationBarFooter(
              label: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Icon(Icons.copyright,color: Colors.grey,),
                Text("Medilink 2023",style: TextStyle(color: Colors.grey),)
              
                ],
              )
            ),
            selectedIndex: selectedIndex,
            items: const [
              //dashboard
              SideNavigationBarItem(
                icon: Icons.dashboard,
                label: 'Dashboard',
              ),
              //statistics
              SideNavigationBarItem(
                icon: Icons.analytics,
                label: 'Statistics',
              ),
              //department
              SideNavigationBarItem(
                icon: Icons.local_hospital_outlined,
                label: 'Departments',
              ),
              //hospital
              SideNavigationBarItem(
                icon: Icons.add_box_outlined,
                label: 'Hospital',
              ),
              //add doctor
              SideNavigationBarItem(
                icon: Icons.group_add,
                label: 'Doctors',
              ),
              //doctor list
              SideNavigationBarItem(
                icon: Icons.group,
                label: 'Doctor list',
              ),
              //telemedicine
              SideNavigationBarItem(
                icon: Icons.medication_rounded,
                label: 'Telemedicine',
              ),
              //feedback
              SideNavigationBarItem(
                icon: Icons.feedback,
                label: 'Feedback',
              ),
             
            ],
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: screen.elementAt(selectedIndex),
          )
        ],
      ),
    );
  }
}