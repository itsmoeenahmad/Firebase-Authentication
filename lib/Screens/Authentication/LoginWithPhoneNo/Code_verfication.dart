import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:studyingfirebase/Screens/home_screen.dart';

import 'check_state1.dart';

class code_verifications_screen extends StatefulWidget {

  String verification;
   code_verifications_screen({super.key, required this.verification});

  @override
  State<code_verifications_screen> createState() => _code_verifications_screenState();
}

class _code_verifications_screenState extends State<code_verifications_screen> {


  //Controller
  TextEditingController _code = TextEditingController();

  //Firebase auth isntance

  FirebaseAuth _auth = FirebaseAuth.instance;

  //message

  showmessage(String data, Color color)
  {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data,style: GoogleFonts.monda(),),backgroundColor: color,));
  }



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Code Verifification Screen",style: GoogleFonts.monda(fontSize: 14),),
        centerTitle: true,
        automaticallyImplyLeading: true
      ),
      body:  SingleChildScrollView(
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
                cursorColor: Colors.black,
                controller: _code,
                decoration: InputDecoration(
                  hintText: "Enter a Sended Code here",
                  hintStyle: GoogleFonts.monda(
                  ),
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black)
                  ),
                  focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black)
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Consumer<check_state1>(
                builder: (BuildContext context, value1, Widget? child) {
                  return InkWell(
                    onTap: () {
                      value1.change_state1(false);
                      setState(() {

                      });
                      final _credential = PhoneAuthProvider.credential(
                          verificationId: widget.verification, smsCode: _code
                          .text.toString());



                      _auth.signInWithCredential(_credential).then((value) =>
                      {
                        value1.change_state1(true),
                        setState(() {

                        }),
                        showmessage("Login Successfully", Colors.green),
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const home_screen())),

                      }).onError((error, stackTrace) =>
                      {
                      value1.change_state1(true),
                        setState(() {

                        }),
                        showmessage(error.toString(), Colors.red)
                      });
                    },
                    child: Container(
                      height: height * 0.06,
                      width: width * 0.6,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Center(child: value1.check1 ?  Text("Login", style: GoogleFonts
                          .monda(color: Colors.white, fontSize: 22)) : CircularProgressIndicator(color: Colors.white,)
                      ),
                    ),
                  );
                } ),
            ],
          ),
        ),
      ),
    );
  }
}
