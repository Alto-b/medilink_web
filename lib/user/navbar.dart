// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
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

  void onNavItemTap(int index) {
    if (isMobile) {
      Navigator.pop(context);
    }
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;

    List<Widget> navItems = [
      buildNavItem(0, "Home"),
      buildNavItem(1, "Our Hospitals"),
      buildNavItem(2, "Our Specialities"),
      buildNavItem(3, "Our Doctors"),
      buildNavItem(4, "Appointments"),
      buildNavItem(5, "Telemedicine"),
      buildNavItem(6, "About us"),
      buildNavItem(7, "Settings"),
    ];

    List<Widget> screens = [
      WebHomepage(),
      HospitalPage(),
      SpecializationPage(),
      DoctorViewPage(),
      BookAppointment(),
      TelemedicinePage(),
      AboutUsPage(),
      SettingsPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 120,
          width: 120,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('lib/assets/medilink.png'),
          ),
        ),
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

  Widget buildNavItem(int index, String title) {
    return TextButton(
      onPressed: () => onNavItemTap(index),
      child: Text(
        title,
        style: navBarItems(selectedIndex == index),
      ),
    );
  }

  TextStyle navBarItems(bool isSelected) {
    return TextStyle(
      color: isSelected ? Colors.black : Colors.black87,
      fontWeight: FontWeight.bold,
      decoration: isSelected ? TextDecoration.underline : null,
    );
  }
}
