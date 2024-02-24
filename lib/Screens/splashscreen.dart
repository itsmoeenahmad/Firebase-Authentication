import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studyingfirebase/Screens/home_screen.dart';
import 'Authentication/login_screen.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {


  //firebase authentication package- instance

  FirebaseAuth authication = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 5),(){

      if(authication.currentUser != null)
        {
         //Navigating to home screen
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const home_screen()));
        }
      else
        {
          //Navigating towards login screen
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const login_screen()));
        }

    });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Center(
        child: Text("Studying Firebase",style: GoogleFonts.monda(fontSize: 20,),),
      ),
    );
  }
}
