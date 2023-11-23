// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medilink/admin/db/hosp_functions.dart';
import 'package:medilink/admin/model/hospmodel.dart';
import 'package:medilink/styles/custom_widgets.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({super.key});

  @override
  State<HospitalPage> createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {

  final _formKey1 = GlobalKey<FormState>();
  final _formKey=GlobalKey<FormState>();
  final _hospitalController=TextEditingController(); 
  final _editController=TextEditingController();


  @override
  Widget build(BuildContext context) {

    getHosp();

    return Scaffold(

      //appbar
      appBar: AppBar(
        title: Text("MANAGE HOSPITALS",style:appBarTitleStyle()),
      ),

      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            child: Container(
              width: 500,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 50,),
                        //textformfield     
                          TextFormField(
                            validator: (value) {
                                   if (value == null || value.isEmpty) {
                                     return 'Cannot be empty';
                                    }
                                     if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                                         return 'Only characters are allowed';
                                        }
                                       return null;
                                   },
                                   controller: _hospitalController,
                                   decoration: InputDecoration(
                                    hintText: "Enter hospital"
                                   ),
                          ),SizedBox(height: 20,),
                    
                          //add button
                           ElevatedButton(
                              onPressed: () {
                                addHospitalButton();
                                _hospitalController.clear();
                              },
                          child: Text("Add"),
                        ),
                          SizedBox(height: 20,),
            
                      //list
            
                      SizedBox(
                        height: 500,
                        child: ValueListenableBuilder(
                          valueListenable: hospListNotifier,
                          builder:(BuildContext ctx,List<HospModel> hospitalList,Widget? child){
                            return ListView.separated(
                              itemBuilder: (ctx,index){
                              final data = hospitalList[index];
            
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: DrawerMotion(), 
                                children:[
                                  //edit
                                  SlidableAction(onPressed: (context) {
                                   _editSheet(context, data.hosp, data.id);
                                  },
                                  icon:Icons.edit,
                                  backgroundColor: Color.fromARGB(255, 10, 112, 196),
                                  ),
                                  //delete
                                  SlidableAction(onPressed: (context) {
                                  deleteHosp(data.id);
                                    _hospitalController.clear();
                                  },
                                  icon:Icons.delete,
                                  backgroundColor: Color.fromARGB(255, 248, 3, 3),
                                  ),
                                 ]),
                              child: ListTile(
                                leading: Text("${index+1}"),
                                title: Text(data.hosp),
                              ),
                            );
                          }, 
                          separatorBuilder: (ctx,index){
                            return const Divider();
                          }, 
                          itemCount: hospitalList.length);
                          } ,
                        ),
                      ),       
                      ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addHospitalButton()async{
    final _hosp = _hospitalController.text.trim();
    if(_hosp.isEmpty){
      return ;
    }
    final _hospital = HospModel(hosp: _hosp,id: -1);
    //print(_hosp);
    addHosp(_hospital);
  }

   void _editSheet(BuildContext context,String department,int id){
      showModalBottomSheet(context: context, builder:(context) {
        _editController.text=department;
                                 return Container(
                                  
                                    child: Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: Form(
                                        key: _formKey1,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: _editController,
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(),
                                                hintText: "Department"
                                              ),
                                            ),SizedBox(height: 25,),
                                            ElevatedButton(onPressed: (){
                                              edithospital(id,_editController.text);
                                              Navigator.of(context).pop();
                                            }, child: Text("SAVE"))
                                          ],
                                        ),
                                      ),
                                    ),
                                 );
                               }, );
  }
}