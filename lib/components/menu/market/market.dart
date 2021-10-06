import 'package:flutter/material.dart';

class Market extends StatefulWidget {
  Market({Key key}) : super(key: key);

  @override
  _Market createState() => _Market();
}

class _Market extends State<Market> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _prix = TextEditingController();
  final _discord = TextEditingController();
  final _size = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[500],
        title: Text("Market"),
      ),
      body: SafeArea(child: Text("market")),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('WTS'),
                  content: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _name,
                                    validator: (value) {
                                      return value.isNotEmpty
                                          ? null
                                          : "Enter any text";
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Nom de la paire",
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _prix,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      return value.isNotEmpty
                                          ? null
                                          : "Enter any text";
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Prix",
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _size,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      return value.isNotEmpty
                                          ? null
                                          : "Enter any text";
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Size",
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _discord,
                                    validator: (value) {
                                      return value.isNotEmpty
                                          ? null
                                          : "Enter any text";
                                    },
                                    decoration: InputDecoration(
                                      hintText: "ID Discord",
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Fermer'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Valider'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          print("bonjour");
                        }
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.edit),
          backgroundColor: Colors.grey),
    );
  }
}
