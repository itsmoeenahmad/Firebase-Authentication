import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:studyingfirebase/Screens/Authentication/LoginWithPhoneNo/login_with_ph_no.dart';
import 'package:studyingfirebase/Screens/Authentication/registernow.dart';
import 'package:studyingfirebase/state_management.dart/login_loadingstate.dart';
import '../home_screen.dart';

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  //Controllers
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController forget_password = TextEditingController();

  //Firebase Authentication class object/instance

  FirebaseAuth authentication = FirebaseAuth.instance;

  //Message for showing the error

  message(data) {
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
          title: Text(
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
                Text("Studying Firebase",
                    style: GoogleFonts.monda(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    )),
                SizedBox(
                  height: height * 0.01,
                ),
                Text("Keep Hardworking",
                    style: GoogleFonts.monda(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )),
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
                  height: height * 0.004,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        showDialog(context: (context), builder: (context){
                          return Dialog(
                            child: Container(
                              height: height*0.35,
                              width: width*0.8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child:  Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Reset Password",style: GoogleFonts.monda(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700
                                    ),),

                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        TextField(
                                          controller: forget_password,
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
                                        Text("~Only registered email address recieve the link",style: GoogleFonts.monda(
                                          color: Colors.deepOrange,
                                          fontSize: 11
                                        ),),
                                      ],
                                    ),



                                    InkWell(
                                      onTap: (){
                                        authentication.sendPasswordResetEmail(email: forget_password.text.toString()).then((value) =>
                                        {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text("Link for Reset Password Send"),
                                        ),
                                        ),
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const login_screen())),
                                        }).onError((error, stackTrace) => {
                                          message(error.toString()),
                                        });

                                      },
                                      child: Container(
                                          height: height * 0.055,
                                          width: width * 0.6,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Send Link",
                                              style: GoogleFonts.monda(
                                                  fontSize: 22,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                          )),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                      },
                      child: Text("~Reset Password",style: GoogleFonts.monda(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w700
                      ),),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Consumer<login_loadingstate>(
                  builder: (BuildContext context, value, Widget? child) {
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
                              content: Text(
                                'Fill the Data',
                                style: GoogleFonts.monda(),
                              ),
                            ),
                          );
                        } else {
                          //signing user

                          authentication
                              .signInWithEmailAndPassword(
                                  email: email_controller.text.toString(),
                                  password: password_controller.text.toString())
                              .then((value) => {
                                    //showing the success message
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Success"),
                                      backgroundColor: Colors.green,
                                    )),
                                    //Navigating towards the home screen
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const home_screen()))
                                  })
                              .onError((error, stackTrace) =>
                                  {message(error.toString())});

                          Timer(Duration(seconds: 5), () {
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
                          child: value.check
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    "Login Now",
                                    style: GoogleFonts.monda(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal),
                                  ),
                                )),
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
                      "Don't have account!  ",
                      style: GoogleFonts.monda(
                          color: Colors.deepOrange, fontSize: 14),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const registernow()));
                        },
                        child: Text("Register Now",
                            style: GoogleFonts.monda(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            )))
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),

                Text("Login With",style: GoogleFonts.monda(
                  color: Colors.deepOrange
                ),),

                SizedBox(
                  height: height * 0.02,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => login_with_phone_number()));
                      },
                      child: Container(
                        height: height * 0.055,
                        width: width * 0.11,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30)),
                        child: const  Center(
                            child: Icon(Icons.phone,color: Colors.white,)
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width*0.055,
                    ),
                    InkWell(
                      onTap: () async {
                        //Showing the Google Accounts

                        GoogleSignInAccount? google_user =
                        await GoogleSignIn().signIn();

                        //Authentication for the Google Selected account

                        UserCredential? user_data;

                        if(google_user==null)
                          {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Failed! Try Again", style: GoogleFonts.monda()),
                              backgroundColor: Colors.red,
                            ));
                          }
                        else
                          {
                            GoogleSignInAuthentication? user_auth =
                            await google_user?.authentication;

                            //login credentials

                            AuthCredential user_checking =
                            GoogleAuthProvider.credential(
                                accessToken: user_auth?.accessToken,
                                idToken: user_auth?.idToken);

                            //storing in firebase
                            user_data = await authentication
                                .signInWithCredential(user_checking);
                          }




                        if (user_data?.user!.email != null) {
                          //showing the success message
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Success", style: GoogleFonts.monda()),
                            backgroundColor: Colors.green,
                          ));
                          //Navigating towards the home screen
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => home_screen()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Failed! Try Again",
                              style: GoogleFonts.monda(),
                            ),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      child: Container(
                        height: height * 0.055,
                        width: width * 0.11,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                        child:
                        // Icon(FontAwesomeIcons.google,color: Colors.white,size: 16,),
                        Center(
                          child: Image.asset("assets/images/google_logo.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),


              ],
            ),
          ),
        ));
  }
}
