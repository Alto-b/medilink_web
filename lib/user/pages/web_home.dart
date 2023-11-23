
// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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

          
          ],
        ),
      ),
    );
  }
}