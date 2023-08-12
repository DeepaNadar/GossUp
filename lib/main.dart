import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:frenzygram/screens/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


late Size mq; //Global object for accessing screen size   

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 152, 61, 89),
      statusBarIconBrightness: Brightness.light,));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GossUp',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 3,
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
        titleTextStyle:TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 19
          ),
        backgroundColor: Color.fromARGB(255, 152, 61, 89),
        ),
        
        primarySwatch: Colors.pink,
      ),
      home: const LoginScreen()
    );
  }
}

_initializeFirebase() async{
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var result = await FlutterNotificationChannel.registerNotificationChannel(
    description: 'For showing message notification.',
    id: 'chats',
    importance: NotificationImportance.IMPORTANCE_HIGH,
    name: 'Chats',
    
);
log("\nNotification Channel Result: $result");
}


