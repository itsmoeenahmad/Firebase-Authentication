import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyingfirebase/Screens/Authentication/LoginWithPhoneNo/check_state.dart';
import 'package:studyingfirebase/state_management.dart/loading_state.dart';
import 'package:studyingfirebase/state_management.dart/login_loadingstate.dart';
import 'Screens/Authentication/LoginWithPhoneNo/check_state1.dart';
import 'Screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>register_loadingstate()),
        ChangeNotifierProvider(create: (context)=>login_loadingstate()),
        ChangeNotifierProvider(create: (context)=>check_state()),
        ChangeNotifierProvider(create: (context)=>check_state1()),
      ],
      child: const SafeArea(
        child:  MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Flutter FireBase Studying",
          home: splashscreen(),
        ),
      ),
    );
  }
}
