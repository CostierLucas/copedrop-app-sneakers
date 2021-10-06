import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  ///
  FirebaseAuth auth = FirebaseAuth.instance;
  Widget buildPage(BuildContext context, DocumentSnapshot doc) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          width: 280,
          height: 500,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.grey),
                height: 200,
                width: 300,
                child: Image.network(doc['image'], fit: BoxFit.cover),
              ),
              Padding(padding: EdgeInsets.all(16.0)),
              Text(
                'Drop du jour : '.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.all(16.0)),
              Expanded(
                child: Text(
                  doc['text'].replaceAll("\\n", "\n"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    PageController test;
    if (size.width > 500) {
      test = PageController(viewportFraction: 0.5);
    } else {
      test = PageController(viewportFraction: 0.8);
    }
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('home').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();
        return PageView.builder(
          controller: test,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) =>
              buildPage(context, snapshot.data.docs[index]),
        );
      },
    );
  }
}
