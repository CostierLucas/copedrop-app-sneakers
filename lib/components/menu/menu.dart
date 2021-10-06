import 'package:flutter/material.dart';
import 'lexique/lexique.dart';
import 'market/market.dart';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);
  @override
  _Menu createState() => _Menu();
}

class _Menu extends State<Menu> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[500],
        title: Text("MENU"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_downward,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      print("tapped");
                    },
                    child: Container(
                      height: 150,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10.0,
                            offset: Offset(0.0, 0.75),
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            child: Text(
                              'SOON ⌛️ ',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Text(
                              'GUIDES',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10.0,
                          offset: Offset(0.0, 0.75),
                        ),
                      ],
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => Market()),
                          // );
                        },
                        child: Container(
                          height: 150,
                          padding: EdgeInsets.all(10),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                child: Text(
                                  'SOON ⌛️ ',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Text(
                                  'MARKET',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 150,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10.0,
                          offset: Offset(0.0, 0.75),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          child: Text(
                            'SOON ⌛️ ',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Text(
                            'BOT',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10.0,
                          offset: Offset(0.0, 0.75),
                        ),
                      ],
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Lexique()),
                          );
                        },
                        child: Container(
                          height: 150,
                          padding: EdgeInsets.all(10),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                child: Text(
                                  '📚',
                                  style: TextStyle(fontSize: 50),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Text(
                                  'LEXIQUE',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
