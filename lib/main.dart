import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:device_preview/device_preview.dart';
import 'package:learnflutternew/Chooseshoecategory.dart';
import 'package:learnflutternew/Courses.dart';
import 'package:learnflutternew/CoursesDetails.dart';
import 'package:learnflutternew/Info.dart';
import 'package:learnflutternew/Signup.dart';

import 'package:learnflutternew/home.dart';
import 'package:learnflutternew/home_screen_loader.dart';
import 'package:learnflutternew/shoes_cart.dart';
import 'package:learnflutternew/shoes_love.dart';
import 'package:learnflutternew/utils/theme.dart';

import 'Login.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase
  runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(primaryColor: kColorPrimary),
      initialRoute: '$HomeScreenLoader',
      routes: {
        '$Home': (_) => const Home(),
        '$Choosesshoecategory': (_) => const Choosesshoecategory(),
        '$Courses': (_) => const Courses(),
        '$CoursesDetails': (_) => CoursesDetails(),
        '$ShoesLove': (_) => ShoesLove(),
        '$ShoesCart': (_) => ShoesCart(),
        '$HomeScreenLoader': (_) => HomeScreenLoader(),
        '$Login': (_) => Login(),
        '$SignUp': (_) => SignUp(),
        '$Info': (_) => Info(),
      },
    );
  }
}
