import 'package:flutter/material.dart';
import '../components/raffles/shoesCard.dart';
import 'package:copedrop/components/profil/profilPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:copedrop/components/notifications/notifications.dart';
import 'package:copedrop/components/home/home.dart';
import 'package:copedrop/components/menu/menu.dart';

/// This is the stateful widget that the main application instantiates.
class MybottomNavigation extends StatefulWidget {
  MybottomNavigation({Key key}) : super(key: key);

  @override
  _MybottomNavigation createState() => _MybottomNavigation();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MybottomNavigation extends State<MybottomNavigation> {
  FirebaseAuth auth = FirebaseAuth.instance;

  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = [
    Home(),
    CardShoes(),
    Notifs(),
    ProfilPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _url(String url) async {
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
        backgroundColor: Colors.grey[500],
        centerTitle: false,
        // leading: getPseudo(context),
        title: const Text('Copedrop'),
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.instagram),
            onPressed: () {
              _url("https://www.instagram.com/copedrop/");
            },
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.grey,
        notchMargin: 4,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 55,
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Accueil',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Releases',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notification_important_outlined),
                label: 'Alertes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Paramètres',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            onTap: _onItemTapped,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context).push(_createRoute());
        },
        tooltip: 'Increment',
        child: Icon(
          Icons.apps_outlined,
        ),
        elevation: 2.0,
      ),
    );
  }

  Widget getPseudo(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(auth.currentUser.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Container(
            child: Column(
              children: [
                Text(data['pseudo']),
              ],
            ),
          );
        }
        return Text('pseudo');
      },
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Menu(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
