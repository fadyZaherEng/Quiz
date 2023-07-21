import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizes/helper/bindings_app.dart';
import 'package:quizes/layout/home/home_screen.dart';
import 'package:quizes/modules/result_screen/result_screen.dart';
import 'package:quizes/modules/welcome/welcome_screen.dart';
import 'package:quizes/shared/styles/theme.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Quiz App',
      theme: darkTheme(),
      initialBinding: BilndingsApp(),
      //home:  WelcomeScreen(),
      getPages: [
        GetPage(name: '/', page: () => WelcomeScreen()),
        GetPage(name: QuizScreen.routeName, page: () =>  QuizScreen()),
        GetPage(name: ResultScreen.routeName, page: () =>  ResultScreen()),
      ],
    );
  }
}
