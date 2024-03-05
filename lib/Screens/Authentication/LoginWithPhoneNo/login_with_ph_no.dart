import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:studyingfirebase/Screens/Authentication/LoginWithPhoneNo/Code_verfication.dart';
import 'package:studyingfirebase/Screens/Authentication/LoginWithPhoneNo/check_state.dart';

class login_with_phone_number extends StatefulWidget {
  const login_with_phone_number({super.key});

  @override
  State<login_with_phone_number> createState() => _login_with_phone_numberState();
}

class _login_with_phone_numberState extends State<login_with_phone_number> {

  //Firebase auth instance

  FirebaseAuth _auth = FirebaseAuth.instance;

  //Controller

  TextEditingController _phone_controller = TextEditingController();

  //show message

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
        centerTitle: true,
        title: Text("Login With Phone Number Screen",style: GoogleFonts.monda(
          fontSize: 14,
        ),),
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                 controller: _phone_controller,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "Enter your Mobile Number",
                  helperText: "~Mobile Number With Country Code",
                  helperStyle: GoogleFonts.monda(
                    fontSize: 10,
                    color: Colors.deepOrangeAccent
                  ),
                  hintStyle: GoogleFonts.monda(
                  ),
                  focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black)
                  ),
                  contentPadding: EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black)
                  ),
          
                ),
                           ),
              SizedBox(
                height: height * 0.05,
              ),
              Consumer<check_state>(

                builder: (BuildContext context, check_state value, Widget? child) {
               return InkWell(
                    onTap: () {
                      if (_phone_controller.text.isEmpty) {
                        showmessage("Enter a phone number ", Colors.red);
                      }
                      else {
                        value.change_state(false);
                        setState(() {}); //false
                        _auth.verifyPhoneNumber(
                            phoneNumber: _phone_controller.text.toString(),
                            verificationCompleted: (_) {},
                            verificationFailed: (e) {
                              showmessage(e.toString(), Colors.red);
                              value.change_state(true);
                              setState(() {
                              });
                            },
                            codeSent: (String verification, int? token) {
                              value.change_state(true);
                              setState(() {}); //true
                              showmessage("Code Sent Successfuslly", Colors.green);

                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      code_verifications_screen(
                                        verification: verification,)));
                            },
                            codeAutoRetrievalTimeout: (e) {
                              value.change_state(true);
                              setState(() {

                              });
                              showmessage(e.toString(), Colors.red);
                            });
                      }
                    },
                    child: Container(
                      height: height * 0.06,
                      width: width * 0.6,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Center(child: value.check? Text("Send Code", style: GoogleFonts
                          .monda(color: Colors.white, fontSize: 22)) : CircularProgressIndicator(color: Colors.white,)
                      ),
                    ),
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
