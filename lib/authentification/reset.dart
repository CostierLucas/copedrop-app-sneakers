import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Reset extends StatefulWidget {
  @override
  _Reset createState() => _Reset();
}

class _Reset extends State<Reset> {
  String email, password;
  final _email = TextEditingController();

  final auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        backgroundColor: Colors.grey[600],
        title: Text("Mot de passe oublié"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _email,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Entrez votre email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.white,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
              ),
              SizedBox(height: 30),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await auth.sendPasswordResetEmail(email: _email.text);
                      await showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Mot de passe oublié'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(
                                      "Un lien de réinitialisation a été envoyé sur votre boite mail."),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Fermer'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      Navigator.pop(context);
                    } catch (err) {
                      print(err);
                    }
                  },
                  child: Text("Confirmer"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
