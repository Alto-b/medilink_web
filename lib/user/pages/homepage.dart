// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:medilink/admin/pages/doctor_list.dart';
import 'package:medilink/user/pages/about_us.dart';
import 'package:medilink/user/pages/book_appointment.dart';
import 'package:medilink/user/pages/doctor_view.dart';
import 'package:medilink/user/pages/feedback.dart';
import 'package:medilink/user/pages/hospitals.dart';
import 'package:medilink/user/pages/my_appointments.dart';
import 'package:medilink/user/pages/specializations.dart';
import 'package:medilink/user/pages/telemedicine.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:Image.asset('lib/assets/medilink.png',
        width: 120),
          centerTitle: true,
          toolbarHeight: 90,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            //carousal  
             CarouselSlider(
              options: CarouselOptions(
                height: 200, 
                enlargeCenterPage: true, 
                aspectRatio: 16/9, 
                //aspectRatio: 4/3,
                enableInfiniteScroll: true,
                autoPlay: true, 
                autoPlayInterval: Duration(seconds: 3), 
                autoPlayAnimationDuration: Duration(milliseconds: 1000), 
                autoPlayCurve: Curves.fastOutSlowIn, 
                //autoPlayCurve: Curves.easeIn,
                enlargeStrategy: CenterPageEnlargeStrategy.height, 
              ),
              items: [
                // Add your carousel items here, e.g., Container, Image, or any widget
                Container(
                  //color: Colors.red,
                  child: Center(child: Image.asset('lib/assets/banner1.png')),
                ),
                Container(
                  //color: Colors.blue,
                  child: Center(child: Image.asset('lib/assets/banner2.png')),
                ),
                Container(
                  //color: Colors.green,
                  child: Center(child: Image.asset('lib/assets/banner3.png')),
                ),
              ],
            ),
            SizedBox(height: 0,),
            
           //row1

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                children: [
                  Row(                
                    children: [ SizedBox(width: 15,) , Text("Hospital",style: headingsTextStyle(),)],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                       //our hospitals
                      Container(
                        alignment: Alignment.center,
                        height: 100,width: 100,
                        decoration:optionsBoxDecoration() ,
                        child: Column(children: [
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HospitalPage(),));
                          }, child: Column(
                            children: [
                              Icon(Icons.business,size: 50,),
                              Text("Our ",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                              Text(" hospitals",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                            ],
                          ))
                        ]),
                      ),
                      //our specialization 
                      Container(
                        alignment: Alignment.center,
                        height: 100,width: 100,
                        decoration:optionsBoxDecoration() ,
                        child: Column(children: [
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SpecializationPage(),));
                          }, child: Column(
                            children: [
                              Icon(Icons.star_border,size: 50,),
                              Text("Our",style: TextStyle(fontSize:11),textAlign: TextAlign.center),
                              Text("Specializations",style: TextStyle(fontSize: 10.5),textAlign: TextAlign.center),
                            ],
                          ))
                        ]),
                      ),
                      //our doctors
                      Container(
                        alignment: Alignment.center,
                        height: 100,width: 100,
                        decoration:optionsBoxDecoration() ,
                        child: Column(children: [
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorViewPage(),));
                          }, child: Column(
                            children: [
                              Icon(Icons.group_outlined,size: 50,),
                              Text("Our ",style: TextStyle(fontSize:11),textAlign: TextAlign.center),
                              Text(" Doctors",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                            ],
                          ))
                        ]),
                      ),
                     
                    ],                  ),SizedBox(height: 20,),

                  //row 2

                   Row(                
                    children: [ SizedBox(width: 15,) , Text("Services",style: headingsTextStyle(),)],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                     //book an appointment
                      Container(
                        alignment: Alignment.center,
                        height: 100,width: 100,
                        decoration:optionsBoxDecoration() ,
                        child: Column(children: [
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BookAppointment(),));
                          }, child: Column(
                            children: [
                              Icon(Icons.calendar_month_outlined,size: 50,),
                              Text("Book an appointment",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                            ],
                          ))
                        ]),
                      ),
                      //my appointment
                      Container(
                        alignment: Alignment.center,
                        height: 100,width: 100,
                        decoration:optionsBoxDecoration() ,
                        //color: Colors.red,
                        child: Column(children: [
                          // Icon(Icons.schedule),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppointments(),));
                          }, child: Column(
                            children: [
                              Icon(Icons.schedule_rounded,size: 50,),
                              Text("My Appointments",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                            ],
                          ))
                        ]),
                      ),
                      //our doctors
                      Container(
                        alignment: Alignment.center,
                        height: 100,width: 100,
                        decoration:optionsBoxDecoration() ,
                        //color: Colors.red,
                        child: Column(children: [
                          // Icon(Icons.schedule),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TelemedicinePage(),)); 
                             },
                         child: Column(
                            children: [
                              Icon(Icons.medication_outlined,size: 50,),
                              Text("Telemedicine",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                              Text(" Services",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                            ],
                          ))
                        ]),
                      ),
                    ],
                  ),SizedBox(height: 20,),

                  //row 3

                   Row(                
                    children: [ SizedBox(width: 15,) , Text("Reach to us",style: headingsTextStyle(),)],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 100,width: 100,
                        decoration:optionsBoxDecoration() ,
                        //color: Colors.red,
                        child: Column(children: [
                          // Icon(Icons.schedule),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage(),));
                          }, child: Column(
                            children: [
                              Icon(Icons.feedback_outlined,size: 50,),
                              Text("Provide",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                              Text("Feedback",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                            ],
                          ))
                        ]),
                      ),
                      //our doctors
                      Container( 
                        alignment: Alignment.center,
                        height: 100,width: 100,
                        decoration:optionsBoxDecoration() ,
                        //color: Colors.red,
                        child: Column(children: [
                          // Icon(Icons.schedule),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage(),));                          }, child: Column(
                            children: [
                              Icon(Icons.info_outline,size: 50,),
                              Text("About ",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                              Text(" Us",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                            ],
                          ))
                        ]),
                      ),
                    // blank space
                      //SizedBox(width: 10,),
                      Container(
                        alignment: Alignment.center,
                        height: 100,width: 100,
                        //decoration:BoxDecoration(border: Border.all(color: Colors.blueGrey),borderRadius: BorderRadius.circular(20)) ,
                        //color: Colors.red,
                        child: Column(children: [
                          // Icon(Icons.schedule),
                          // TextButton(onPressed: (){}, child: Column(
                          //   children: [
                          //    // Icon(Icons.business,size: 50,),
                          //     Text(" ",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                          //     Text("",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                          //   ],
                          // ))
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          ],
        ),
      ),

        //floating action button to dialer
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        //mini: true,
        backgroundColor: Colors.red[400],
        onPressed: () {
          _launchDialer('123456789'); // Replace '123456789' with the specific number
        },
        child: Icon(Icons.local_hospital, color: Colors.white), // Use the ambulance icon
      ),

    );
  }

 

    //launch dialer
  void _launchDialer(String phoneNumber) async{

           Uri phoneno = Uri.parse('tel:$phoneNumber');
       if (await launchUrl(phoneno)) {
              //dialer opened
          }else{
          SnackBar(content: Text("couldn't launch dialer"));
      }
    } 

//text styles
 TextStyle headingsTextStyle() => TextStyle(color:Colors.deepPurple,fontWeight: FontWeight.w700,fontSize: 18);


//options style

  BoxDecoration optionsBoxDecoration() => BoxDecoration(
    color: Colors.white,
    // border: Border.all(
    //   //color: Colors.blueGrey,width: 0.5
    //   ),
      borderRadius: BorderRadius.circular(10),
      boxShadow:[
        BoxShadow(
          spreadRadius: 1,
           blurRadius: 3,
           //offset: Offset(-3, -1),
          color:Colors.grey.withOpacity(.5),
          )] );

}