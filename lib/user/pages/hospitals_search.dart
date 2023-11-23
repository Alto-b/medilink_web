import 'package:flutter/material.dart';
import 'package:medilink/admin/model/hospmodel.dart';
import 'package:medilink/admin/db/hosp_functions.dart';

class HospSearchDelegate extends SearchDelegate<HospModel> {
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
    final List<HospModel> hospitalList = hospListNotifier.value;

    final filteredHospitals = query.isEmpty
        ? hospitalList
        : hospitalList.where((hosp) =>
            hosp.hosp.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.separated(
      itemBuilder: (context, index) {
        final data = filteredHospitals[index];
        return ListTile(
          title: Text(data.hosp),
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
