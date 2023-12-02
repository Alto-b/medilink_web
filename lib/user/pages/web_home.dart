
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:medilink/styles/custom_widgets.dart';

class WebHomepage extends StatefulWidget {
  const WebHomepage({super.key});

  @override
  State<WebHomepage> createState() => _WebHomepageState();
}

class _WebHomepageState extends State<WebHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            //SizedBox(height: 35,),
            // Image.asset('lib/assets/hospital.jpeg',width: double.infinity,height: 600,),
            Container(
              height: 500,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('lib/assets/hospital.jpeg',),fit: BoxFit.cover)
                
              ),
            ),
            //  CarouselSlider(
            //     options: CarouselOptions(
            //       height: 300, 
            //       enlargeCenterPage: true, 
            //       aspectRatio: 20/7, 
            //       //aspectRatio: 4/3,
            //       enableInfiniteScroll: true,
            //       autoPlay: true, 
            //       autoPlayInterval: Duration(seconds: 3), 
            //       autoPlayAnimationDuration: Duration(milliseconds: 1000), 
            //       //autoPlayCurve: Curves.fastOutSlowIn, 
            //       autoPlayCurve: Curves.easeIn,
            //       enlargeStrategy: CenterPageEnlargeStrategy.height, 
            //     ),
            //     items: [
            //       // Add your carousel items here, e.g., Container, Image, or any widget
            //       Container(
            //         //color: Colors.red,
            //         child: Center(child: Image.asset('lib/assets/banner1.png')),
            //       ),
            //       Container(
            //         //color: Colors.blue,
            //         child: Center(child: Image.asset('lib/assets/banner2.png')),
            //       ),
            //       Container(
            //         //color: Colors.green,
            //         child: Center(child: Image.asset('lib/assets/banner3.png')),
            //       ),
            //     ],
            //   ),
          SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[150]
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //card1
                  Container(
                    decoration: optionsBoxDecoration(),
                    width: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('lib/assets/apphomepage.png',height: 450,),
                    ),
                  ),
                  //text1
                  Container(
                    width: 800,
                    child: Text(style:TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ), 
                    'MediLink is your all-in-one health companion, simplifying healthcare access for everyone. From booking appointments with top-rated doctors and specialists to accessing reliable health information and managing your medical records, MediLink ensures a seamless healthcare experience in the palm of your hand.')
                  ),
                  
                ],
              ),
            ),
          ),

            SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[150]
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //text1
                  Container(
                    width: 800,
                    child: Text(style:TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ), 
                    'MediLink revolutionizes the healthcare landscape, offering a comprehensive and user-friendly platform that empowers individuals to take control of their health. Our app seamlessly connects users with a network of experienced doctors and specialists, allowing hassle-free appointment scheduling and virtual consultations. Whether you need routine check-ups, specialized care, or expert medical advice, MediLink ensures that quality healthcare is always within reach.')
                  ),
                    //card1
                  Container(
                    decoration: optionsBoxDecoration(),
                    width: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('lib/assets/appointments.png',height: 450,),
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
          SizedBox(height: 30,),
          Container(
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
              color: Colors.grey[200]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //map
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Image.asset('lib/assets/map.png',width: 600,),
                  ),
                ),

                      //contact us
                   Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text("Contact Us",style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.indigo),
                        ),
                           Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.phone)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.email)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.facebook)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.telegram)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.map))
                  ],
                ),
                 Text('Medilink hospital,7th cross,HSR layout,bengaluru')
                     ],
                   ),   
                   SizedBox(height: 10,),
            ],),
          )
          
          ],
        ),
      ),
    );
  }
}