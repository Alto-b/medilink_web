// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink/admin/pages/appointment_view.dart';
import 'package:medilink/admin/pages/department.dart';
import 'package:medilink/admin/pages/doctor.dart';
import 'package:medilink/admin/pages/doctor_list.dart';
import 'package:medilink/admin/pages/feedbackview.dart';
import 'package:medilink/admin/pages/hospital.dart';
import 'package:medilink/admin/pages/statistics.dart';
import 'package:medilink/admin/pages/telemedicine_view.dart';
import 'package:medilink/guest/pages/signup.dart';
import 'package:medilink/styles/custom_widgets.dart';
import 'package:medilink/user/pages/telemedicine.dart';
import 'package:side_navigation/side_navigation.dart';


class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  List<String> titles=[
  'APPOINTMENTS',
  'STATISTICS',
  'DEPARTMENTS',
  'HOSPITALS',
  'DOCTORS',
  'DOCTORS LIST',
  'TELEMEDICINE',
  'FEEDBACK',
  
  ];

  final List<WidgetBuilder> pageBuilders = [
      (context) => AppointmentViewPage(),
      (context) => StatisticsPage(),
      (context) => DepartmentPage(),
      (context) => HospitalPage(),
      (context) => AddDoctor(),
      (context) => DoctorListPage(),
      (context) => TelemedicineViewPage(),
      (context) => FeedbackViewPage(),
    ];

  List<Icon> icons=[
 Icon(
    Icons.book_online,
  size:50,
  color:Colors.black,
  ),
  Icon(
    Icons.analytics,
  size:50,
  color:Colors.black,
  ),
  Icon(
    Icons.local_hospital_outlined,
  size:50,
  color:Colors.black,
  ),
   Icon(
    Icons.add_box_rounded,
  size:50,
  color:Colors.black,
  ),
  Icon(
    Icons.group_add,
  size:50,
  color:Colors.black,
  ),
  Icon(
    Icons.group,
  size:50,
  color:Colors.black,
  ),
  Icon(
    Icons.medication_rounded,
  size:50,
  color:Colors.black,
  ),
  Icon(
    Icons.feedback,
  size:50,
  color:Colors.black,
  ),
];
  
  List<Color> colors=[
  Color.fromARGB(120, 12, 97, 15),
  Color.fromARGB(136, 215, 140, 20),
  Color.fromARGB(122, 9, 215, 67),
  Color.fromARGB(122, 9, 215, 67),
  Color.fromARGB(123, 72, 8, 176),
  Color.fromARGB(106, 17, 115, 195),
  Color.fromARGB(106, 17, 115, 195),
  Color.fromARGB(100, 199, 113, 14),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      

      body: Stack(
        children: <Widget>[dashBg, content],
      ),
    );
  }

  get dashBg => Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(color: Colors.blueGrey),
          ),
          Expanded(
            flex: 5,
            child: Container(color: Colors.transparent),
          ),
        ],
      );

  // ignore: avoid_unnecessary_containers
  get content => Container(
    //color: Colors.blueGrey,
        child: Column(
          children: <Widget>[
            header,
            grid,
          ],
        ),
      );

  get header => ListTile(
    contentPadding: EdgeInsets.only(left: 20, right: 20, top: 50),
    title: Text(
      'Welcome Admin !',
      style: GoogleFonts.play(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w500),
    ),
    subtitle: Text(
      'DASHBOARD',
      style: TextStyle(color: Colors.white),
    ),
    trailing: InkWell(
      onTap: () {
        logOut(context);
      },
      child: CircleAvatar(
        radius:20,
        //backgroundImage: NetworkImage('https://i.ibb.co/YZWjL9Y/Screenshot-2023-10-22-204311-removebg-preview.png'),
        backgroundColor: Colors.transparent,
        child: Icon(Icons.logout,color: Colors.white,size: 25,)
      ),
    ),
  );

  get grid => Expanded(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: GridView.count(
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            crossAxisCount: 2,
            childAspectRatio: .90,
            children: List.generate(titles.length, (index) {
              return InkWell(
                onTap: (){
                  Navigator.of(context).push(
                        MaterialPageRoute(builder:pageBuilders[index],)
                       );
                },
                child: Card(
                  color: colors[index],
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[icons[index], Text(titles[index])],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
    );



//logout fn
     logOut(BuildContext context){
      showDialog(context: context, 
      builder: (BuildContext context){
          return AlertDialog(
            title: Text("Log Out"),
            content: Text("Are you sure ?"),
            actions: [
              TextButton(onPressed: (){
                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage(),));
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignUpPage(),), (route) => false);
              }, child: Text("Confirm")),
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Close"))
            ],
          );
      });
    }
  }
