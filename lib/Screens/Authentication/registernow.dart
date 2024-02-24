import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studyingfirebase/Screens/Authentication/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:studyingfirebase/state_management.dart/loading_state.dart';

import '../home_screen.dart';

class registernow extends StatefulWidget {
  const registernow({super.key});

  @override
  State<registernow> createState() => _registernowState();
}

class _registernowState extends State<registernow> {
  //Controllers
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  //Firebase Auth Package Instance/Object

  FirebaseAuth authentication = FirebaseAuth.instance;


  Future<dynamic> message(data) async{
    await ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data),));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        drawerEnableOpenDragGesture: true,
        appBar: AppBar(
          title:  Text(
            "Register Screen",
            style: GoogleFonts.monda(color: Colors.white, fontSize: 25),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(45),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                 Text(
                  "Studying Firebase",
                  style: GoogleFonts.monda(fontSize: 30,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.italic)
                ),
                 Text(
                  "Keep Hardworking",
                  style: GoogleFonts.monda( fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextField(
                  controller: email_controller,
                  decoration: InputDecoration(
                      hintText: "Enter Your Email",
                      hintStyle: GoogleFonts.monda(),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      )),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                TextField(
                  controller: password_controller,
                  decoration: InputDecoration(
                      hintText: "Enter Your Password",
                      hintStyle: GoogleFonts.monda(),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      )),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Consumer<register_loadingstate>(
                  builder: (BuildContext context, register_loadingstate value, Widget? child) {
                    return InkWell(
                        onTap: () {
                          value.change_state(); //true



                          print("Check is ${value.check} in ontap");
                          if (email_controller.text.isEmpty ||
                              password_controller.text.isEmpty) {
                            print("Check is ${value.check} in if condition");
                            value.change_state(); //false
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Fill the Data'),
                              ),
                            );
                          } else {
                            authentication
                                .createUserWithEmailAndPassword(
                                email: email_controller.text.toString(),
                                password: password_controller.text.toString())
                                .then((value) => {

                                  //showing the success message

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success"),backgroundColor: Colors.green,)),



                              //After successfully registration- navigating to login screen
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const login_screen()))
                            })
                                .onError((error, stackTrace) => {
                              message(error.toString())
                            });

                            Timer(Duration(seconds: 5),(){
                              print("5 seconds");
                              value.change_state(); //false
                              print("Check is ${value.check} in else condition");
                            });

                          }
                        },
                        child: Container(
                          height: height * 0.055,
                          width: width * 0.6,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child:  Center(
                            child: value.check ? const CircularProgressIndicator(color: Colors.white) :  Text(
                              "Register Now",
                              style: GoogleFonts.monda( fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal)
                            ),
                          ),
                        ),

                    );
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      "Already have account!  ",
                      style: GoogleFonts.monda(color: Colors.deepOrange,
                          fontStyle: FontStyle.italic,
                          fontSize: 14),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const login_screen()));
                        },
                        child:  Text(
                          "Login",
                          style: GoogleFonts.monda( color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                          )),),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
