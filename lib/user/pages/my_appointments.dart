import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:medilink/admin/db/appointment_functions.dart';
import 'package:medilink/admin/model/appointment_model.dart';
import 'package:medilink/guest/model/usermodel.dart';
import 'package:medilink/guest/pages/login.dart';
import 'package:medilink/styles/custom_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppointments extends StatefulWidget {
  const MyAppointments({super.key});

  @override
  State<MyAppointments> createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {

@override
void initState(){
  super.initState();
  getUser();      
}

    String userEmail = ''; 

  UserModel? currentUser;
  
   int age=0;

//to get logged in user
Future<void> getUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  userEmail = prefs.getString('currentUser') ?? '';

  final userBox = await Hive.openBox<UserModel>('user_db');
  currentUser = userBox.values.firstWhere(
    (user) => user.email == userEmail,
  );

  prefs.setString('userName', currentUser?.fullname ?? '');

//getting appointment details
  getUserAppointment(currentUser!.fullname);

  setState(() {});
}



  @override
  Widget build(BuildContext context) {

    

    return Scaffold(

      appBar: AppBar(
        title: Text("MY APPOINTMENTS",style: appBarTitleStyle(),),
        actions: [
          IconButton(onPressed: (){
            print(currentUser!.fullname);
            print(currentUser!.email);
          }, icon: Icon(Icons.search))
        ],
      ),

      body: currentUser!=null ?
       SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                    height: 700,
                    child: ValueListenableBuilder(
                      valueListenable: userAppointmentListNotifier,
                      builder: (BuildContext ctx, List<AppointmentModel> userAppointmentList,Widget? child) {
                        
                      
                      return ListView.separated(
                      itemBuilder:((context, index) {
                        final data=userAppointmentList[index];
                
                        return Container(
                          child: ListTile(
                            horizontalTitleGap: 20,
                            contentPadding: EdgeInsets.all(5),
                            leading: Text("   ${index+1}"),
                            title: InkWell
                            (onTap: () { },
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               Text(
                                    DateFormat('dd-MM-yyyy HH:mm').format(data.date),
                                    style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
                                  ),
                                Text('${data.title} ${data.name} ',style: TextStyle(fontWeight: FontWeight.w700),),
                                Text("Email : ${data.email}, Mob:${data.mobile}"),
                                Text("${data.gender} / ${data.marital}"),
                    
                              ],
                            )),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5,),
                                //Text('Date: ${data.mobile}'),
                                Text('Address: ${data.address}'),
                               // Text('booked by: ${data.user}'),
                                //Text('Mobile: ${data.mobile}'), 
                              ],
                            ),                  
                          ),
                        );
                      }) , 
                     separatorBuilder: ((context, index) {
                      return const Divider();
                      }), 
                    itemCount:userAppointmentList.length);
                   }, ),
                  ),
          ],
      
        ),
      )
      :Center(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 200,),
            Text("USER NOT LOGGED IN"),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
            }, child: Text("PROCEED TO LOGIN"))
          ],
        ),
      ),
    )
    );
  }
}