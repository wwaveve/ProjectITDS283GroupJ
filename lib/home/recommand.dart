import 'package:flutter/material.dart';
import 'package:project_wongnok/home/Food_detail.dart';
import 'package:flutter/material.dart';
import 'package:project_wongnok/home/Food_detail.dart';
import 'package:project_wongnok/service/Api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Recommand extends StatefulWidget {
  @override
  _Recommand createState() => _Recommand();
}

class _Recommand extends State<Recommand> {
  late Future<List<ApiCall>> _apiCalls;

  @override
  void initState() {
    super.initState();
    _apiCalls = _fetchApiCalls();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<ApiCall>>(
          future: _apiCalls,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final apiCalls = snapshot.data!;
              return ListView.builder(
                itemCount: apiCalls.length,
                itemBuilder: (context, index) {
                  final apiCall = apiCalls[index];
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
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
