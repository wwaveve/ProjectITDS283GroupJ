import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_wongnok/login/Login.dart';
import 'package:project_wongnok/login/profile.dart';
import '../home.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final fromKey = GlobalKey<FormState>();
  Profile profile = Profile(email: "email", password: "password");
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return SafeArea(
                child: Scaffold(
                    backgroundColor: Colors.white,
                    body: Column(children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 3,
                        child: Image.asset('asset/icons/LOGO.png'),
                      ),
                      Expanded(
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Form(
                                      key: fromKey,
                                      child: SingleChildScrollView(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                            const Text(
                                              'Username',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Colors.black,
                                              ),
                                              child: TextFormField(
                                                validator: MultiValidator([
                                                  RequiredValidator(
                                                      errorText:
                                                          "Please Enter Email"),
                                                  EmailValidator(
                                                      errorText:
                                                          "Invaild Email")
                                                ]),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                onSaved: (String? email) {
                                                  profile.email = email;
                                                },
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  prefixIcon: Icon(
                                                    Icons.account_circle,
                                                    color: Colors.white,
                                                  ),
                                                  hintText: 'Email',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            const Text(
                                              'Password',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Colors.black,
                                              ),
                                              child: TextFormField(
                                                validator: RequiredValidator(
                                                    errorText:
                                                        "Please Enter Password"),
                                                obscureText: true,
                                                onSaved: (String? password) {
                                                  profile.password = password;
                                                },
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  prefixIcon: Icon(
                                                    Icons.lock,
                                                    color: Colors.white,
                                                  ),
                                                  hintText: 'Password',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            const Text(
                                              'Confirm Password',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Colors.black,
                                              ),
                                              child: TextFormField(
                                                obscureText: true,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  prefixIcon: Icon(
                                                    Icons.lock,
                                                    color: Colors.white,
                                                  ),
                                                  hintText: 'Confirm Password',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 35),
                                            GestureDetector(
                                              onTap: () async {
                                                if (fromKey.currentState!
                                                    .validate()) {
                                                  fromKey.currentState?.save();
                                                  try {
                                                    await FirebaseAuth.instance
                                                        .createUserWithEmailAndPassword(
                                                            email:
                                                                profile.email!,
                                                            password: profile
                                                                .password!);
                                                    fromKey.currentState
                                                        ?.reset();
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Register Complete",
                                                        gravity: ToastGravity
                                                            .CENTER);
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return LoginScreen();
                                                    }));
                                                  } on FirebaseAuthException catch (e) {
                                                    // print(e.message);
                                                    // print(e.code);
                                                    Fluttertoast.showToast(
                                                        msg: e.message!,
                                                        gravity:
                                                            ToastGravity.TOP);
                                                  }
                                                  fromKey.currentState?.reset();
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Colors.black,
                                                ),
                                                child: const Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Text(
                                                      'Register',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ]))))))
                    ])));
          }
          return Scaffold(
              appBar: AppBar(
            title: Text("GG"),
          ));
        });
  }
}
