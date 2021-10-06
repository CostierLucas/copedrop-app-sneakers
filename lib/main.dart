import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './authentification/signIn.dart';
import './navigation/bottomNavigation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io' show Platform;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  if (!Platform.isMacOS) {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    await FirebaseMessaging.instance.getToken();
    await FirebaseMessaging.instance.subscribeToTopic('notifs');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.messageId}');

      if (message.notification != null) {
        print(message.notification);
      }
    });
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey,
          primaryColor: Colors.blue,
          textTheme: TextTheme(
            bodyText2: TextStyle(color: Colors.black),
          ),
          textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.black,
              primary: Colors.white,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        title: 'Flutter Demo',
        home: auth.currentUser == null ? SignIn() : MybottomNavigation());
  }
}
