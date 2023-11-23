

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medilink/guest/model/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<List<UserModel>> userListNotifier=ValueNotifier([]);

//to add users
Future<void> addUser(UserModel value) async{
  final userDB = await Hive.openBox<UserModel>('user_db');
  final _id=await userDB.add(value);
  value.id=_id;
  userListNotifier.value.add(value);
  userListNotifier.notifyListeners();
}

//to delete users
Future<void> deleteUser(int id) async{
  final userDB = await Hive.openBox<UserModel>('user_db');
  await userDB.delete(id);
}

//to get user count
Future<int> userStats() async{
  final userDB = await Hive.openBox<UserModel>('user_db');
  final userCount=userDB.length;
  return userCount;
}

//to get user info
// Future<void> getUser()async{
//   final userDB = await Hive.openBox<UserModel>('user_db');
//   userListNotifier.value.clear();
//   userListNotifier.value.addAll(userDB.values);
//   userListNotifier.notifyListeners();
// }



// //to get details of specific user
// Future<void> getSpecificUser() async {
//   // Get the current user's email from SharedPreferences
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String currentUserEmail = prefs.getString('currentUser') ?? '';

//   // Open the Hive box
//   final userDB = await Hive.openBox<UserModel>('user_db');

//   // Get the user details based on the current user's email
//   UserModel? currentUser = userDB.values.firstWhere(
//     (user) => user.email == currentUserEmail,
//     //orElse: () => null,
//   );

//   // Clear and update the notifier with the user details
//   userListNotifier.value.clear();
//   if (currentUser != null) {
//     userListNotifier.value.add(currentUser);
//   }
//   userListNotifier.notifyListeners();
// }
