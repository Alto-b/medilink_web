import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medilink/admin/model/appointment_model.dart';
import 'package:medilink/admin/model/deptmodel.dart';
import 'package:medilink/admin/model/doctor_model.dart';
import 'package:medilink/admin/model/feedback_model.dart';
import 'package:medilink/admin/model/hospmodel.dart';
import 'package:medilink/admin/model/telemedicine_model.dart';
import 'package:medilink/admin/pages/dashboard.dart';
import 'package:medilink/admin/sidebar.dart';
import 'package:medilink/guest/model/usermodel.dart';
import 'package:medilink/guest/pages/login.dart';
import 'package:medilink/guest/pages/splash.dart';
import 'package:medilink/user/navbar.dart';
import 'package:medilink/user/pages/homepage.dart';
import 'package:side_navigation/side_navigation.dart';


// ignore: constant_identifier_names
const SAVE_KEY_NAME ="UserLoggedIn";
Future<void> main() async {

   WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

   Hive.openBox<DepartmentModel>('dept_db');
   Hive.openBox<HospModel>('hosp_db');
   Hive.openBox<UserModel>('user_db');
   Hive.openBox<FeedBackModel>('feedback_db');
   Hive.openBox<TelemedicineModel>('telemedicine_db');
   Hive.openBox<AppointmentModel>('appointment_db');
   Hive.openBox<DoctorModel>('doctor_db');
  
  if(!Hive.isAdapterRegistered(DepartmentModelAdapter().typeId)){
      Hive.registerAdapter(DepartmentModelAdapter());
  }
  if(!Hive.isAdapterRegistered(HospModelAdapter().typeId)){
      Hive.registerAdapter(HospModelAdapter());
  }
  if(!Hive.isAdapterRegistered(UserModelAdapter().typeId)){
    Hive.registerAdapter(UserModelAdapter());
  }
  if(!Hive.isAdapterRegistered(FeedBackModelAdapter().typeId)){
    Hive.registerAdapter(FeedBackModelAdapter());
  }
  if(!Hive.isAdapterRegistered(TelemedicineModelAdapter().typeId)){
    Hive.registerAdapter(TelemedicineModelAdapter());
  }
  if(!Hive.isAdapterRegistered(AppointmentModelAdapter().typeId)){
    Hive.registerAdapter(AppointmentModelAdapter());
  }
  if(!Hive.isAdapterRegistered(DoctorModelAdapter().typeId)){
    Hive.registerAdapter(DoctorModelAdapter());
  }

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medilink',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      
      
      home: FutureBuilder(
        future: _initialization,
        builder:(context, snapshot) {
          if(snapshot.hasError){
            print("error");
          }
          if(snapshot.connectionState == ConnectionState.done){
            return LoginPage();
          }
          return CircularProgressIndicator();
        }, 
      )
    );
  }
}
