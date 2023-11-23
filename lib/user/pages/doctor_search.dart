import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medilink/admin/model/doctor_model.dart';
import 'package:medilink/admin/db/doctor_functions.dart';

class DoctorSearchDelegate extends SearchDelegate<DoctorModel> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions to display at the top right (e.g., a clear button).
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading widget (usually a back button).
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
       Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Build and return the search results based on the query.
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Build and return search suggestions based on the query.
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    final List<DoctorModel> hospitalList = doctorListNotifier.value;

    final filteredHospitals = query.isEmpty
        ? hospitalList
        : hospitalList.where((doc) =>
            doc.name.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.separated(
      itemBuilder: (context, index) {
        final data = filteredHospitals[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage:FileImage(File(data.photo)),
          ),
          title: Text(data.name),
          onTap: () {
            // You can handle what happens when a suggestion is tapped.
            close(context, data);
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: filteredHospitals.length,
    );
  }
}
