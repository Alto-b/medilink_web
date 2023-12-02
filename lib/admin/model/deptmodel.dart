
import 'dart:typed_data';

import 'package:hive/hive.dart';
part 'deptmodel.g.dart';

@HiveType(typeId: 1)
class DepartmentModel extends HiveObject{

  @HiveField(0)
   int? id;

  @HiveField(1)
   String dept;

  @HiveField(2)
    Uint8List photo;

  

  DepartmentModel({required this.dept,required this.photo, this.id});
}
