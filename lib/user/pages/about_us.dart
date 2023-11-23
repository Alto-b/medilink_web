// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medilink/styles/custom_widgets.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {


//  GoogleMapController? mapController;
//   final Set<Marker> _markers = {}; // Initialize markers as an empty set

//   @override
//   void initState() {
//     super.initState();
//     // Initialize _initialLocation here
//     _markers.add(
//       Marker(
//         markerId: MarkerId('hospital-marker'),
//         position: LatLng(37.7749, -122.4194),
//         infoWindow: const InfoWindow(title: 'Hospital Name'),
//       ),
//     );
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text("ABOUT US",style: appBarTitleStyle()),
          centerTitle: true,
          toolbarHeight: 80,
        ),

        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.asset('lib/assets/medilink.png',width: 200,)
                    ],
                  ),
                      SizedBox(height: 40,),
                  Text("Medilink Hospitals is one of the topmost healthcare providers in India. Our hospitals are renowned for their medical infrastructure and expertise as we have some of the finest doctors in the country, supported by ultra-modern technologies, research-based care in a warm & comforting environment. Our trusted doctors and a team of specialists work closely together to provide the best of healthcare.",
                      textAlign: TextAlign.justify,style: aboutUsText(),),
                      SizedBox(height: 30,),
                   Text("Our Values",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.indigo),),   
                   SizedBox(height: 10,),

                  //card1
                   Card(
                      color: Colors.grey[50],
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Title(color: Colors.grey, child: Text("Excellence",style: cardtitle(),)),
                            SizedBox(height: 10,),
                            Text("Surpassing current benchmarks constantly by continually challenging our ability and skills to take the organization to greater heights",style: cardcontent(),),
                            SizedBox(height: 10,),
                            Text("-Albert Einstein",style: cardname(),)
                          ],
                        ),
                      ),
                    ),SizedBox(height: 20,),

                    //card2
                   Card(
                      color: Colors.grey[50],
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Title(color: Colors.grey, child: Text("Respect",style: cardtitle(),)),
                            SizedBox(height: 10,),
                            Text("Treating people with utmost dignity, valuing their contributions and fostering a culture that allow each individual to rise to their fullest potential",style: cardcontent(),),
                            SizedBox(height: 10,),
                            Text("-Mahatma Gandhi",style: cardname(),)
                          ],
                        ),
                      ),
                    ),SizedBox(height: 20,),

                     //card3
                   Card(
                      color: Colors.grey[50],
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Title(color: Colors.grey, child: Text("Passion",style: cardtitle(),)),
                            SizedBox(height: 10,),
                            Text("Going the extra mile willingly, with a complete sense of belongingness and purpose while adding value to our stakeholders",style: cardcontent(),),
                            SizedBox(height: 10,),
                            Text("-Steve Jobs",style: cardname(),)
                          ],
                        ),
                      ),
                    ),SizedBox(height: 25,),


                    //contact us
                   Text("Contact Us",style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.indigo),),   
                   SizedBox(height: 10,),
                
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
                // Row(
                //   children: [
                //       GoogleMap(initialCameraPosition: CameraPosition(
                //         target:LatLng(37.7749, -122.4194),
                //         zoom: 15,
                //         ),
                //         onMapCreated: (GoogleMapController controller){
                //           mapController=controller;
                //         },
                //         markers: _markers,)
                //   ],
                // )
                  
                ],
              ),
            ),
          ),
        ),

        // floatingActionButton: FloatingActionButton(
        //     onPressed: (){},
        //     child: Icon(Icons.call,color: Colors.white,),
        //     tooltip: "Contact us",
        //     elevation: 20,
        //     backgroundColor:Color.fromARGB(143, 102, 240, 107),),
    );
  }
}