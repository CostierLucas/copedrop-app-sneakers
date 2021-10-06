import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:copedrop/authentification/signIn.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilPage extends StatefulWidget {
  ProfilPage({Key key}) : super(key: key);

  @override
  _ProfilPage createState() => _ProfilPage();
}

class _ProfilPage extends State<ProfilPage> {
  final auth = FirebaseAuth.instance;
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
      backgroundColor: Colors.grey,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              signOut(context),
              TextButton(
                onPressed: () => _url("http://copedrop.fr"),
                child: Text(
                  "copedrop.fr",
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget signOut(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.red, onPrimary: Colors.white),
        child: Text('Déconnexion'),
        onPressed: () {
          auth.signOut();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => SignIn()));
        },
      ),
    );
  }
}
