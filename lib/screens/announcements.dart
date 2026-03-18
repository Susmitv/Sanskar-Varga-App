import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AnnouncementsScreen extends StatefulWidget {
  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {

  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // to avoid duplicate notifications
  Set<String> shownIds = {};

  @override
  void initState() {
    super.initState();

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
    InitializationSettings(android: androidSettings);

    notificationsPlugin.initialize(settings);
  }

  void showNotification(String message) {
    notificationsPlugin.show(
      0,
      "📢 New Announcement",
      message,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'Announcements',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Announcements"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('announcements')
            .snapshots(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No announcements yet"));
          }

          var docs = snapshot.data!.docs;

          // 🔔 NOTIFICATION LOGIC
          for (var doc in docs) {
            if (!shownIds.contains(doc.id)) {
              showNotification(doc['message']);
              shownIds.add(doc.id);
            }
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {

              var data = docs[index];

              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Icon(Icons.campaign, color: Colors.orange, size: 28),

                      SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              data['message'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(height: 6),

                            Text(
                              data.data().containsKey('date') ? data['date'] : "",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}