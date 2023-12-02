// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medilink/styles/custom_widgets.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {

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
              child: Container(
                width: 900,
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
                    Text('''MediLink revolutionizes the healthcare landscape, offering a comprehensive and user-friendly platform that empowers individuals to take control of their health. Our app seamlessly connects users with a network of experienced doctors and specialists, allowing hassle-free appointment scheduling and virtual consultations. Whether you need routine check-ups, specialized care, or expert medical advice, MediLink ensures that quality healthcare is always within reach.

                            Beyond appointments, MediLink serves as an invaluable health hub. Users can access a wealth of health information, from articles and tips to stay well-informed to personalized insights to help them make informed health decisions. The app also provides a secure and centralized repository for medical records, making it easy for users to track their health history and share vital information with healthcare providers.

                            MediLink prioritizes user experience, offering intuitive navigation, personalized recommendations, and features that cater to diverse health needs. Whether you're managing chronic conditions, seeking preventive care, or simply staying proactive about your well-being, MediLink is your trusted companion on your health journey.''',
                        textAlign: TextAlign.justify,style: aboutUsText(),),
                        SizedBox(height: 30,),
                     Text("Our Values",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.indigo),),   
                     SizedBox(height: 10,),
              
                    //card1
                     SizedBox(
                      width: 600,
                       child: Card(
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
                        ),
                     ),SizedBox(height: 20,),
              
                      //card2
                     SizedBox(
                      width: 600,
                       child: Card(
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
                        ),
                     ),SizedBox(height: 20,),
              
                       //card3
                     SizedBox(
                      width: 600,
                       child: Card(
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
                  ],
                ),
              ),
            ),
          ),
        ),

    );
  }
}