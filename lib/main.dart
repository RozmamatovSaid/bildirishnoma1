import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import 'views/home_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final androidInitializationSettings = AndroidInitializationSettings(
    "@mipmap/ic_launcher",
  );

  final iOs = DarwinInitializationSettings();
  await Firebase.initializeApp();
  flutterLocalNotificationsPlugin.initialize(
    InitializationSettings(android: androidInitializationSettings, iOS: iOs),
  );
  var status = await Permission.notification.status;
  if (status != PermissionStatus.granted) {
    status = await Permission.notification.request();
  }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(
        flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
      ),
    );
  }
}
