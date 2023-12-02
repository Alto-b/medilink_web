// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:medilink/admin/db/dept_functions.dart';
import 'package:medilink/admin/model/deptmodel.dart';
import 'package:medilink/styles/custom_widgets.dart';

class DepartmentPage extends StatefulWidget {
  const DepartmentPage({super.key});

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {

  @override
  void  initState(){
    super.initState();
    getDepartment();
  }

  final _formKey = GlobalKey<FormState>();
  final _departmentController=TextEditingController();
  final _editController=TextEditingController();
  final _formKey1 = GlobalKey<FormState>();

  bool imageAvailable = false;
  bool imageAvailableE = false;
  late Uint8List imageFile;
  late Uint8List imageFileE;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Departments",style: appBarTitleStyle(),),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: 500,
                child: Form(
                  key: _formKey,
                  child: Column(
                  children: [
                    GestureDetector(
                       onTap: () async {
                        final image = await ImagePickerWeb.getImageAsBytes();
              
                        setState(() {
                          imageFile = image!;
                          imageAvailable=true;
                        });
                      },
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[100]
                        ),
                        child: imageAvailable?Image.memory(imageFile) :Icon(Icons.add_a_photo),
                      ),
                    ),SizedBox(height: 10,),
                    TextFormField(
                      controller: _departmentController,
                      validator: (value){
                    if(value==null || value.isEmpty){
                      return 'cannot be empty';
                    }
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                       return 'Only characters are allowed';
                    }
                    return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Department"
                      ),
                    ),SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){
                      addDepartmentButton();
                      _departmentController.clear();
                      
                    }, child: Text("ADD")),
                  ],
                )),
              ),SizedBox(height: 50,),
              
              //listing departments

              SizedBox(
                  height: 750,
                  width: 750,
                  child: ValueListenableBuilder(
                    valueListenable: deptListNotifier,
                    builder: (BuildContext ctx, List<DepartmentModel> departmentList,Widget? child) {

                    return ListView.separated(
                    itemBuilder:((context, index) {
                      final data=departmentList[index];

                      return Slidable(
                              endActionPane: ActionPane(
                                motion:DrawerMotion() ,
                             children: [
                              //edit
                              SlidableAction(onPressed: (context) {

                             _editSheet(context,data.photo,data.dept,data.id!,);
                                 },
                              icon:Icons.edit,
                              backgroundColor: Color.fromARGB(255, 10, 112, 196),
                              ),
                              //delete
                              SlidableAction(onPressed: (context) {
                                deleteDept(data.id!);
                                _departmentController.clear();
                              },
                              icon:Icons.delete,
                              backgroundColor: Color.fromARGB(255, 248, 3, 3),
                              ),
                             ] ),
                           
                                      
    
                        child: Container(
                          child: ListTile(
                            horizontalTitleGap: 20,
                            contentPadding: EdgeInsets.all(5),
                            leading: Text("${index+1}"),
                            title: Row(
                              children: [
                                CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              backgroundImage: MemoryImage(data.photo)
                            ),    SizedBox(width: 20,),
                                Text(data.dept),
                              ],
                            ),                        
                          ),
                        ),
                        
                      );
                    }) , 
                   separatorBuilder: ((context, index) {
                    return const Divider();
                    }), 
                  itemCount:departmentList.length);
                 }, ),
                ),
            
            ],

            
          ),
        ),
      ),
    );
  }

//to add department
Future<void> addDepartmentButton() async{
  final _dept=_departmentController.text.trim();
  final imagePath=imageFile;
  if(_dept.isEmpty){

  }
  else{
    final _department = DepartmentModel(dept: _dept, photo: imagePath);
    addDepartment(_department);
    //print(imagePath);
    setState(() {
      imageAvailable=false;
    });
    
  }
}

void _editSheet(BuildContext context,Uint8List photo,String department,int id){
    _editController.text=department;
     imageFileE = photo;
      showModalBottomSheet(context: context, builder:(context) {
        
        //_selectedImage=photo as File?;
      return SingleChildScrollView(
        child: SizedBox(  
          height: 600, 
               child: Padding(
               padding: const EdgeInsets.all(25.0),
               child: Form(
                 key: _formKey1,
                  child: Column(
                     children: [
           //edit photo
          
                       Row(
                        children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child:GestureDetector(
                       onTap: () async {
                        final image = await ImagePickerWeb.getImageAsBytes();
              
                        setState(() {
                          imageFileE = image!;
                          imageAvailableE=true;
                        });
                      },
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[100]
                        ),
                        child: imageAvailableE?Image.memory(imageFileE) :Icon(Icons.add_a_photo),
                      ),
                    ),
                  ),
                ]),SizedBox(height: 20,),
                             TextFormField(
                      controller: _editController,
                      decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Edit Department"
                 ),
                       ),SizedBox(height: 25,),
              ElevatedButton(onPressed: (){
                    //print("add button clicked");
                  
                    editDepartment(id,_editController.text,imageFileE);
                    
                    _departmentController.clear();
                    Navigator.pop(context);
                  },
                   child: Text("Edit")),   
                       ],
                        ),
                    ),
                ),
             ),
      );
       }, );
  }
}