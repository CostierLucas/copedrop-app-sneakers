import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:copedrop/navigation/bottomNavigation.dart';
import './reset.dart';
import './signUp.dart';

class SignIn extends StatefulWidget {
  @override
  _SignIn createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  String email, password;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo.png",
                width: MediaQuery.of(context).size.width * 0.50,
              ),
              SizedBox(height: 30),
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
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () =>
                      _signIn(_email.text.trim(), _password.text.trim()),
                  child: Text(
                    "Connexion",
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  },
                  child: Text("Créer un compte"),
                ),
              ),
              TextButton(
                child: Text(
                  'Mot de passe oublié',
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline),
                ),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Reset()),
                  ),
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _signIn(String _email, String _password) async {
    String errorMessage;
    try {
      //Create Get Firebase Auth User
      if (_formKey.currentState.validate()) {
        final userr = await auth.signInWithEmailAndPassword(
            email: _email, password: _password);
        if (userr.user.emailVerified) {
          //Success
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MybottomNavigation()));
        } else {
          return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Email'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text("Veuillez vérifier votre email."),
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
                  TextButton(
                    child: Text('Renvoyer un email'),
                    onPressed: () async {
                      await user.sendEmailVerification();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Votre adresse email n'a pas le bon format.";
          break;
        case "wrong-password":
          errorMessage = "Mot de passe erroné";
          break;
        case "user-not-found":
          errorMessage = "Utilisateur introuvable";
          break;
        case "user-disabled":
          errorMessage = "Utilisateur désactivé";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests. Try again later.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur de connexion'),
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
