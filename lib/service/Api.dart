import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  //...
  Future<List<ApiCall>> getData() async {
    final response = await http.get(Uri.parse('https://my-api.marksirapop.repl.co/products'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ApiCall.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
  //...
}




ApiCall apiCallFromJson(String str) => ApiCall.fromJson(json.decode(str));

String apiCallToJson(ApiCall data) => json.encode(data.toJson());

class ApiCall {
  ApiCall({
    required this.nameRestaurant,
    required this.imageRestaurant,
    required this.nameFood,
    required this.imageFood,
    required this.descriptionRes,
  });

  String nameRestaurant;
  String imageRestaurant;
  String nameFood;
  String imageFood;
  String descriptionRes;

  factory ApiCall.fromJson(Map<String, dynamic> json) => ApiCall(
        nameRestaurant: json["name_restaurant"],
        imageRestaurant: json["image_restaurant"],
        nameFood: json["name_food"],
        imageFood: json["image_food"],
        descriptionRes: json["description_res"],
      );

  Map<String, dynamic> toJson() => {
        "name_restaurant": nameRestaurant,
        "image_restaurant": imageRestaurant,
        "name_food": nameFood,
        "image_food": imageFood,
        "description_res": descriptionRes,
      };
}

