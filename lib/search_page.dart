import 'package:flutter/material.dart';
import 'package:project_wongnok/home/Food_detail.dart';
import 'package:project_wongnok/service/Api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: TextField(
          decoration: InputDecoration(hintText: 'Search'),
          onChanged: (value) {
            setState(() {
              _searchText = value;
            });
          },
        ),
      ),
      body: FutureBuilder<List<ApiCall>>(
        future: _fetchApiCalls(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final apiCalls = snapshot.data!;
            final filteredApiCalls = apiCalls.where((apiCall) => apiCall
                .nameFood
                .toLowerCase()
                .contains(_searchText.toLowerCase()));
            return ListView.builder(
              itemCount: filteredApiCalls.length,
              itemBuilder: (context, index) {
                final apiCall = filteredApiCalls.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodDetail(apiCall: apiCall),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Image.network(apiCall.imageFood),
                        ListTile(
                          title: Text(apiCall.nameFood),
                          subtitle: Text(apiCall.nameRestaurant),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Future<List<ApiCall>> _fetchApiCalls() async {
  final url = Uri.parse('https://my-api.marksirapop.repl.co/products');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<ApiCall>((json) => ApiCall.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load API data');
  }
}
