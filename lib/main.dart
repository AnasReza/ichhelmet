import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'screens/home_screen.dart';
import 'routes.dart';
import 'package:ich1/theme/style.dart';



void main() {
  runApp(App());
}


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TableTopApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeUtils.defaultAppThemeData,
      initialRoute: '/',
      routes: appRoutes,
      // home: TestWebSocket(),
    );
  }
}





