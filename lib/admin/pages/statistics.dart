// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medilink/admin/db/appointment_functions.dart';
import 'package:medilink/admin/db/dept_functions.dart';
import 'package:medilink/admin/db/doctor_functions.dart';
import 'package:medilink/admin/db/telemedicine_functions.dart';
import 'package:medilink/admin/model/doctor_model.dart';
import 'package:medilink/admin/pages/appointment_view.dart';
import 'package:medilink/admin/pages/doctor_list.dart';
import 'package:medilink/admin/pages/telemedicine_view.dart';
import 'package:medilink/guest/db/user_functions.dart';
import 'package:medilink/guest/pages/login.dart';
import 'package:medilink/styles/custom_widgets.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("STATISTICS",style: appBarTitleStyle(),),
        actions: [
          // IconButton(onPressed: () {
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
          // }, icon:Icon( Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: 4, // Number of items in the GridView
          itemBuilder: (context, index) {
            // You can customize each grid item based on the index
            switch (index) {
//user count
              case 0:
                return Container(
                  decoration: statsContainer(),
                  child: FutureBuilder<int>(
                    future: userStats(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final userCount = snapshot.data!;
                        return Center(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('USERS',style: statisticsCardTitle(),),
                            Text('$userCount',style: statisticsCardCount(),),
                          ],
                        ));
                      }
                    },
                  ),
                );
//doctor count
              case 1:
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorListPage(),));
                  },
                  child: Container(
                    decoration: statsContainer(),
                    child: FutureBuilder<int>(
                      future: doctorStats(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
                          final docCount = snapshot.data!;
                          return Center(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('DOCTORS',style: statisticsCardTitle(),),
                              Text('$docCount',style: statisticsCardCount(),),
                            ],
                          ));
                        }
                      },
                    ),
                  ),
                );
//appointment count
              case 2:
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>AppointmentViewPage()));
                  },
                  child: Container(
                    decoration: statsContainer(),
                    child: FutureBuilder<int>(
                      future: appointmentStats(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
                          final appointmentCount = snapshot.data!;
                          return Center(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('APPOINTMENTS',style: statisticsCardTitle(),),
                              Text('$appointmentCount',style: statisticsCardCount(),),
                            ],
                          ));
                        }
                      },
                    ),
                  ),
                );
//telemedicine count
              case 3:
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>TelemedicineViewPage()));
                  },
                  child: Container(
                    decoration: statsContainer(),
                    child: FutureBuilder<int>(
                      future: telemedicineStats(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
                          final telemedicineCount = snapshot.data!;
                          return Center(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('TELEMEDICINE',style: statisticsCardTitle(),),
                              Text('$telemedicineCount',style: statisticsCardCount(),),
                            ],
                          ));
                        }
                      },
                    ),
                  ),
                );
              default:
                return Container(); // Return an empty container for other indices
            }
          },
        ),
      ),
    );
  }

}
