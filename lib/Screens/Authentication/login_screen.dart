import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:studyingfirebase/Screens/Authentication/LoginWithPhoneNo/login_with_ph_no.dart';
import 'package:studyingfirebase/Screens/Authentication/registernow.dart';
import 'package:studyingfirebase/state_management.dart/loading_state.dart';
import 'package:studyingfirebase/state_management.dart/login_loadingstate.dart';

import '../home_screen.dart';
import 'LoginWithPhoneNo/Code_verfication.dart';

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  //Controllers
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  //Firebase Authentication class object/instance

  FirebaseAuth authentication = FirebaseAuth.instance;

  //Message for showing the error

  message(data)
  {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        backgroundColor: Colors.red,
        content: Text(data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        drawerEnableOpenDragGesture: true,
        appBar: AppBar(
          title:  Text(
            "Login Screen",
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
                  style: GoogleFonts.monda(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                  )
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                    "Keep Hardworking",
                    style: GoogleFonts.monda(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )
                ),
                SizedBox(
                  height: height * 0.09,
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
                Consumer<login_loadingstate>(builder: (BuildContext context, value, Widget? child) {
                  return InkWell(
                    onTap: () {
                      print("true");
                      value.change_state(); //true
                      if (email_controller.text.isEmpty ||
                          password_controller.text.isEmpty) {
                        value.change_state(); //false
                        ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Fill the Data',style: GoogleFonts.monda(),),
                          ),
                        );
                      } else {
                        //signing user

                        authentication.signInWithEmailAndPassword(
                            email: email_controller.text.toString(),
                            password: password_controller.text.toString()).then((value) =>
                        {
                          //showing the success message
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Success"),backgroundColor: Colors.green,)),
                          //Navigating towards the home screen
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const home_screen()))
                        }).onError((error, stackTrace) => {
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
                      child: value.check ?
                        Center(child:  CircularProgressIndicator(color: Colors.white,),) :  Center(
                  child:  Text(
                  "Login Now",
                  style: GoogleFonts.monda(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal),
                  ),)
                    ),
                  );
                },),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      "Don't have account!  ",
                      style: GoogleFonts.monda(
                          color: Colors.deepOrange,
                          fontSize: 14),
                      ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const registernow()));
                        },
                        child:  Text(
                          "Register Now",
                          style: GoogleFonts.monda(
                              color: Colors.black,
                            fontWeight: FontWeight.w800,
                              fontSize: 14,
                          )
                        ))
                  ],
                ),
                SizedBox(
                  height: height*0.02,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>login_with_phone_number()));
                  },
                  child: Container(
                    height: height*0.04,
                    width: width*0.6,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Center(
                      child: Text(
                        "Login with Phone Number",
                        style: GoogleFonts.monda(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
