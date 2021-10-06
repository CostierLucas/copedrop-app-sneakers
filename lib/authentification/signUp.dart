import 'package:copedrop/authentification/signIn.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _pseudo = TextEditingController();
  String errorMessage;
  User user = FirebaseAuth.instance.currentUser;

  FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        backgroundColor: Colors.grey[600],
        title: Text("Création du compte"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _pseudo,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Entrez votre pseudo';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Pseudo",
                  ),
                ),
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
                  ),
                ),
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Entrez votre mot de passe';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Mot de passe",
                  ),
                ),
                SizedBox(height: 30),
                CheckboxListTileFormField(
                  title: Text(
                    'En cochant cette case je reconnais avoir pris connaissance des CGU et de la politique de confidentialité.',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  onSaved: (bool value) {},
                  validator: (bool value) {
                    if (value) {
                      return null;
                    } else {
                      return 'Veuillez accepter';
                    }
                  },
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => _signUp(
                      _email.text.trim(),
                      _password.text.trim(),
                      _pseudo.text.trim(),
                    ),
                    child: Text("Crée mon compte"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signUp(String _email, String _password, String _pseudo) async {
    try {
      //Create Get Firebase Auth User
      if (_formKey.currentState.validate()) {
        final userr = await auth.createUserWithEmailAndPassword(
            email: _email, password: _password);

        userr.user.sendEmailVerification();
        users.doc(auth.currentUser.uid).set({
          'pseudo': _pseudo,
          'email': _email,
          'date': DateTime.now(),
          'cguandpolitique': true,
        });

        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Email'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                        "Un email de vérification a été envoyé sur votre boîte mail : "),
                    Text(
                      _email,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Fermer'),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => SignIn(),
                      ),
                      (route) =>
                          false, //if you want to disable back feature set to false
                    );
                  },
                ),
              ],
            );
          },
        );
      }
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Votre adresse email n'a pas le bon format.";
          break;
        case "email-already-in-use":
          errorMessage = "Adresse email déjà utilisée.";
          break;
        case "weak-password":
          errorMessage = "Le mot de passe n'est pas assez fort.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(errorMessage),
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
    }
  }
}
