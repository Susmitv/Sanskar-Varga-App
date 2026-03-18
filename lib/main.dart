import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/splash_screen.dart';
import 'screens/dashboard.dart';
import 'screens/announcements.dart';
import 'screens/activities.dart';
import 'screens/links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

// request notification permission
  await messaging.requestPermission();

// subscribe device to topic
  FirebaseMessaging.instance.subscribeToTopic("announcements");

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bal Sanskar Varga',

      home: SplashScreen(),

      routes: {
        "/dashboard": (context) => DashboardScreen(),
        "/announcements": (context) => AnnouncementsScreen(),
        "/activities": (context) => ActivitiesScreen(),
        "/links": (context) => LinksScreen(),
      },
    );
  }
}