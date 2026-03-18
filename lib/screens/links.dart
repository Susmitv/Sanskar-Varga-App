import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class LinksScreen extends StatelessWidget {

  Future<void> openLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Class Links"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('links')
            .snapshots(),
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {

              var data = docs[index];

              return ListTile(
                leading: Icon(Icons.link),
                title: Text(data['title']),
                trailing: Icon(Icons.open_in_new),
                onTap: () {
                  openLink(data['meet_link']);
                },
              );
            },
          );
        },
      ),
    );
  }
}