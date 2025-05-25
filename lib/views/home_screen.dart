import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nottification_2/views/home_body.dart';

class HomeScreen extends StatefulWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  const HomeScreen({super.key, required this.flutterLocalNotificationsPlugin});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseReference _todosRef = FirebaseDatabase.instance.ref().child(
    'masseges',
  );
  final controller = TextEditingController();
  String? token;

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    final title = message.data["title"] ?? "bro";
    final body = message.data["body"] ?? "bro hech nima yoq";

    showSimpleNotification(title: title, body: body);
  }

  @override
  void initState() {
    super.initState();

    initToken();

    _todosRef.onChildAdded.listen((event) {
      final data = event.snapshot.value;
      if (data is Map) {
        final title = data['title'] ?? 'Yangi xabar';
        final body = data['body'] ?? '';
        showSimpleNotification(title: title, body: body);
      }
    });
  }

  void initToken() async {
    final t = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = t;
    });
  }

  void showSimpleNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          "your_channel_id",
          "your_channel_name",
          channelDescription: "your channel description",
          importance: Importance.max,
          priority: Priority.high,
          ticker: "ticker",
        );

    const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails();

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await widget.flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text(
          "Lesson 61",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: HomeBody(token: token!),
    );
  }
}
