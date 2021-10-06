import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Notifs extends StatefulWidget {
  @override
  _Notifs createState() => _Notifs();
}

class _Notifs extends State<Notifs> {
  Widget buildNotifs(BuildContext context, DocumentSnapshot doc) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Card(
        child: Container(
          width: 300,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      "🚨 " + doc['title'].toString().toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    Text(doc['date']),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 250,
                      child: Text(doc["body"]),
                    )
                  ],
                )
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
              ),
            ],
          ),
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('notifications')
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();
        return ListView.builder(
          itemExtent: 80,
          itemCount:
              snapshot.data.docs.length > 10 ? 10 : snapshot.data.docs.length,
          itemBuilder: (context, index) =>
              buildNotifs(context, snapshot.data.docs[index]),
        );
      },
    );
  }
}
