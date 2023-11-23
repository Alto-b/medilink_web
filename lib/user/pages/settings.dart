// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medilink/guest/db/user_functions.dart';
import 'package:medilink/guest/model/usermodel.dart';
import 'package:medilink/guest/pages/login.dart';
import 'package:medilink/main.dart';
import 'package:medilink/styles/custom_widgets.dart';
import 'package:medilink/user/pages/help_center.dart';
import 'package:medilink/user/pages/profilepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool isDarkMode=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:Text("SETTINGS",style:appBarTitleStyle(),)
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child:  Column(
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text("PROFILE",style: listtileTitleStyle(), ),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => ProfilePage(),));
              },
            ),
            ListTile(
              leading: Icon(Icons.remove_red_eye_outlined),
              title: Text("DARK MODE",style: listtileTitleStyle(), ),
              trailing: Switch(value: isDarkMode,onChanged: (value){
                  darkModeToggle();
              },
              activeColor: Colors.deepPurple, // Set the color when the switch is on
              inactiveThumbColor: Colors.grey, // Set the color when the switch is off
              inactiveTrackColor: Colors.grey[300], // Set the track color when the switch is off
                ),
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text("PRIVACY POLICY",style: listtileTitleStyle(),),
              onTap: () => _launchURL('https://www.freeprivacypolicy.com/live/3138d9d9-db48-4658-8f59-7626c7e75765'),
            ),
            ListTile(
              leading: Icon(Icons.shield),
              title: Text("TERMS AND CONDITIONS",style: listtileTitleStyle(),),
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("HELP CENTER",style: listtileTitleStyle(),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HelpCenterPage(),));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text("LOGOUT",style: listtileTitleStyle(),),
              onTap: () =>  logOut(context),
            ),
            // ListTile(
            //   leading: Icon(Icons.delete_forever),
            //   title: Text("DELETE MY ACCOUNT",style: listtileTitleStyle(),),
            //   //onTap: userDeleteButton(context),
            // ),

            Spacer(),
              Column(
              children: [
                Text("v.0.0.1")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:const [
                Icon(Icons.copyright,color: Colors.grey,),
                Text("Medilink 2023",style: TextStyle(color: Colors.grey),)
              ],
            ),
          
            
          ],
        ),
      ),
    );
  }

// Function to launch privacy policy
// void _launchURL() async {
//   const url = 'https://www.freeprivacypolicy.com/live/3138d9d9-db48-4658-8f59-7626c7e75765'; 
//   if (await canLaunchUrl()) {
//     await launchUrl(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

//to set dark mode
void darkModeToggle(){
  setState(() {
    if(isDarkMode){
      isDarkMode=false;
    }
    else if(!isDarkMode){
      isDarkMode=true;
    }
  });
}

//to launch url
void _launchURL(String url) async{

           Uri url = Uri.parse('https://www.freeprivacypolicy.com/live/3138d9d9-db48-4658-8f59-7626c7e75765');
       if (await launchUrl(url)) {
              //dialer opened
          }else{
          SnackBar(content: Text("couldn't launch the page"));
      }
    } 

//log out
void logOut(BuildContext context){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title:Text("Logout"),
          content: Text("Do you want to leave ?"),
          actions: [
            ElevatedButton(onPressed: (){
              signout(context);
            }, child: Text("Yes")),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("No")),
          ],
        );
      });
    }
//signout
  signout(BuildContext ctx) async{

    final _sharedPrefs= await SharedPreferences.getInstance();
  await _sharedPrefs.clear();

    // ignore: use_build_context_synchronously
    Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>LoginPage()), (route) => false);
    _sharedPrefs.setBool(SAVE_KEY_NAME, false);
  }


// //to delete user profile
// userDeleteButton(BuildContext context){
//   showDialog(context: context, builder: (context){
//     return AlertDialog(
//       title: Text("Delete profile"),
//       content: Text("Are you sure ? All your saved data will be lost."),
//       actions: [
//         ElevatedButton(onPressed: (){
//           deleteUserConfirmed(context);
//         }, child: Text("Yes")),
//         ElevatedButton(onPressed: (){
//           Navigator.pop(context);
//         }, child: Text("No")),
//       ],
//     );
//   });

// }

// void deleteUserConfirmed(BuildContext context){
//   signout(context);
//  // deleteUser(currentUser!.id);

// }
  
}