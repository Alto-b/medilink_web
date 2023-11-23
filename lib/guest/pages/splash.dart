// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers, prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:medilink/guest/pages/login.dart';
import 'package:medilink/main.dart';
import 'package:medilink/user/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  
  void initState(){
    checkUserLoggedIn();
    super.initState();
  }

  // ignore: annotate_overrides
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body:Center(
         // animated start

           child:
          //   Image.network(
          //   'https://mir-s3-cdn-cf.behance.net/project_modules/hd/7b400598172263.5ed651c0b9b9f.gif',
          //   width: 500, 
          //   height: 500, 
          // ),

          //Lottie.network('https://lottie.host/c9500319-ddfb-4e34-ad7a-c273566afc48/f0672XXdBI.json')
          Lottie.network('https://lottie.host/bd25ad80-6663-4067-988c-d2573041b658/AZ3HTwnoJp.json')

         //Lottie.asset('lib/assets/loading.json')


        // animated end

      )
    );

  
  }

  Future<void> gotoLogin() async{
    await Future.delayed(Duration(seconds: 5));
    Navigator.of(context).pushReplacement( MaterialPageRoute(builder:(ctx)=>LoginPage()));
  }

  Future<void> checkUserLoggedIn() async{
    final _sharedprefs = await SharedPreferences.getInstance();
   final  _userLoggedIn=_sharedprefs.getBool(SAVE_KEY_NAME);
  if(_userLoggedIn==null || _userLoggedIn==false){
    gotoLogin();
  }
  else{
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>MainPage()));
  }
  }
}