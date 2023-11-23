import 'package:flutter/material.dart';
import 'package:medilink/user/pages/about_us.dart';
import 'package:medilink/user/pages/homepage.dart';
import 'package:medilink/user/pages/profilepage.dart';
import 'package:medilink/user/pages/settings.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int indexNum = 0;

  List screen = const[
    HomePage(),
    //ProfilePage(),
    SettingsPage()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: screen.elementAt(indexNum),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
            BottomNavigationBarItem(
              icon:Icon(Icons.home),
              label: "Home"
               ),
            // BottomNavigationBarItem(
            //   icon:Icon(Icons.person),
            //   label: "Profile"
            //    ),
           BottomNavigationBarItem(
              icon:Icon(Icons.settings),
              label: "Settings"
               ),
        ],
        currentIndex: indexNum,
        showUnselectedLabels: true,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: (int index){
          setState(() {
            indexNum=index;
          });
        },
        ),

    );
  }
}