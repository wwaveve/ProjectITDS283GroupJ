import 'package:flutter/material.dart';
import '../home.dart';
import 'Register.dart';

class Profile {
  String? email;
  String? password;

  Profile({required this.email, required this.password}) {
    ;
    this.email = email!.toString().trim();
  }
}
