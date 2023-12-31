// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medilink/admin/pages/appointment_view.dart';
import 'package:medilink/admin/pages/department.dart';
import 'package:medilink/admin/pages/doctor.dart';
import 'package:medilink/admin/pages/doctor_list.dart';
import 'package:medilink/admin/pages/feedbackview.dart';
import 'package:medilink/admin/pages/hospital.dart';
import 'package:medilink/admin/pages/statistics.dart';
import 'package:medilink/admin/pages/telemedicine_view.dart';
import 'package:medilink/guest/pages/login.dart';
import 'package:medilink/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_navigation/side_navigation.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  int selectedIndex = 0;
   List screen = [
    StatisticsPage(),
    DepartmentPage(),
    HospitalPage(),
    AddDoctor(),
    DoctorListPage(),
    AppointmentViewPage(),
    TelemedicineViewPage(),
    FeedbackViewPage(),
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
              subtitle: Text('ADMIN'),
            ),
            footer: SideNavigationBarFooter(
              label: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Icon(Icons.copyright,color: Colors.grey,),
                Text("Medilink 2023",style: TextStyle(color: Colors.grey),),
                IconButton(onPressed: (){
                  // Call the logOut function when the logout button is pressed
                  logOut(context);
                }, icon: Icon(Icons.logout))
                ],
              )
            ),
            selectedIndex: selectedIndex,
            items:const [
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
                label: 'Appointments',
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
             
              SideNavigationBarItem(
                icon: Icons.logout,
                label: 'Logout',
              ),
            ],
            onTap: (index) {
              if (index == 8) {
                // If the selected item is "Logout", call the logOut function
                logOut(context);
              } else {
                setState(() {
                  selectedIndex = index;
                });
              }
            },
          ),
          Expanded(
            child: screen.elementAt(selectedIndex),
          )
        ],
      ),
    );
  }

  void logOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Do you want to leave?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                signOut(context);
              },
              child: Text("Yes"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No"),
            ),
          ],
        );
      },
    );
  }

  void signOut(BuildContext ctx) async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.clear();

    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => LoginPage()), (route) => false);
    _sharedPrefs.setBool(SAVE_KEY_NAME, false);
  }
}
