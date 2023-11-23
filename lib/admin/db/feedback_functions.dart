

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medilink/admin/model/feedback_model.dart';


ValueNotifier<List<FeedBackModel>> feedbackListener=ValueNotifier([]);

//to add feedbacks
Future<void> addFeedbacks(FeedBackModel value)async{
  final feedbackDB = await Hive.openBox<FeedBackModel>('feedback_db');
  final id = await feedbackDB.add(value);
  final data = feedbackDB.get(id);
  await feedbackDB.put(id,FeedBackModel(title: data!.title, content: data.content,date:data.date,id:id ));
  getFeedbacks();
}

//to view feedbacks
Future<void> getFeedbacks()async{
  final feedbackDB = await Hive.openBox<FeedBackModel>('feedback_db');
  feedbackListener.value.clear();
  feedbackListener.value.addAll(feedbackDB.values);
  feedbackListener.notifyListeners();

}

//to delete feedbacks
Future<void> deleteFeedbacks(int id) async{
  final feedbackDB = await Hive.openBox<FeedBackModel>('feedback_db');
  await feedbackDB.delete(id);
  getFeedbacks();
}