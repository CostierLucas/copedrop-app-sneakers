import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quartet/quartet.dart';
import 'package:copedrop/functions/functions.dart';

class DetailsRaffles extends StatefulWidget {
  final String name;
  final List<dynamic> raffles;
  final String doc;
  final DocumentSnapshot docs;
  final image;

  DetailsRaffles(
      {Key key,
      @required this.name,
      this.raffles,
      this.doc,
      this.docs,
      this.image})
      : super(key: key);

  @override
  _DetailsRaffles createState() => _DetailsRaffles();
}

class _DetailsRaffles extends State<DetailsRaffles> {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference sneakers =
      FirebaseFirestore.instance.collection("sneakers");

  _url(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Text(
          widget.name.toUpperCase(),
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 280,
                width: 380,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Hero(
                  tag: widget.name,
                  child: widget.image,
                ),
              ),
              Container(child: _buildListLink(context))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListLink(BuildContext context) {
    return ListView.builder(
      itemCount: widget.raffles.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var doclink = widget.raffles[index]["link"];
        var link = slice(doclink, doclink.lastIndexOf('^') + 1);

        return Card(
          child: Row(
            children: [
              Expanded(
                child: getLogo(doclink),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black, onPrimary: Colors.white),
                  onPressed: () => setState(
                    () {
                      _url(link);
                    },
                  ),
                  child: Text("Raffle"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
