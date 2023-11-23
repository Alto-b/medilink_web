// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink/styles/custom_widgets.dart';
import 'package:medilink/user/pages/about_us.dart';
import 'package:medilink/user/pages/book_appointment.dart';
import 'package:medilink/user/pages/doctor_view.dart';
import 'package:medilink/user/pages/hospitals.dart';
import 'package:medilink/user/pages/settings.dart';
import 'package:medilink/user/pages/specializations.dart';
import 'package:medilink/user/pages/telemedicine.dart';
import 'package:medilink/user/pages/web_home.dart';

class ResponsiveNavbar extends StatefulWidget {
  const ResponsiveNavbar({Key? key}) : super(key: key);

  @override
  State<ResponsiveNavbar> createState() => _ResponsiveNavbarState();
}

class _ResponsiveNavbarState extends State<ResponsiveNavbar> {
  bool isMobile = false;
  int selectedIndex = 0;

  @override
  // void initState() {
  //   super.initState();

  //   // Schedule a callback for the next frame
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     setState(() {
  //       isMobile = MediaQuery.of(context).size.width > 700 ? false : true;
  //     });
  //   });
  // }

  void onNavItemTap(int index) {
    if (isMobile) {
      Navigator.pop(context); // Close the drawer if it's open.
    }
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;

    List<Widget> navItems = [
      TextButton(onPressed: () => onNavItemTap(0), child: Text("Home",style: navBarItems(),)),
      TextButton(onPressed: () => onNavItemTap(1), child: Text("Our Hospitals",style: navBarItems(),)),
      TextButton(onPressed: () => onNavItemTap(2), child: Text("Our Specialities",style: navBarItems(),)),
      TextButton(onPressed: () => onNavItemTap(3), child: Text("Our Doctors",style: navBarItems(),)),
      TextButton(onPressed: () => onNavItemTap(4), child: Text("Appointments",style: navBarItems(),)),
      TextButton(onPressed: () => onNavItemTap(5), child: Text("Telemedicine",style: navBarItems(),)),
      TextButton(onPressed: () => onNavItemTap(6), child: Text("About us",style: navBarItems(),)),
      IconButton(onPressed:  () => onNavItemTap(7), icon: Icon(Icons.settings))
    ];

    List<Widget> screens = [
      WebHomepage(),
      HospitalPage(),
      SpecializationPage(),
      DoctorViewPage(),
      BookAppointment(),
      TelemedicinePage(),
      AboutUsPage(),
      SettingsPage()
      

    ];

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 120,width: 120, 
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('lib/assets/medilink.png',),
          )),
        centerTitle: false,
        backgroundColor: Colors.greenAccent[100],
        actions: isMobile ? null : navItems,
      ),
      drawer: isMobile
          ? Drawer(
              child: ListView(
                children: navItems,
              ),
            )
          : null,
      body: screens.elementAt(selectedIndex),
    );
  }


}
