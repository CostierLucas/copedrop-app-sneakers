import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:copedrop/components/raffles/linkRaffles.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class CardShoes extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  Widget _buildListRaffles(BuildContext context, DocumentSnapshot doc) {
    image() {
      if (doc['image'] == '' || !doc['image'].contains('https')) {
        return Image(image: AssetImage('assets/noimage.png'));
      } else {
        return Image.network(
          doc['image'],
          width: MediaQuery.of(context).size.width * 0.50,
        );
      }
    }

    return Container(
      margin: EdgeInsets.all(10),
      height: 48.0,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            offset: Offset(0.0, 0.75),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.only(left: 15, top: 8, bottom: 7),
              height: 100,
              width: 80,
              child: Hero(
                tag: doc['name'],
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(10.0),
                    child: Image.network(doc['image'], fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                if (doc["raffles"] != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsRaffles(
                        name: doc['name'],
                        raffles: doc['raffles'],
                        doc: doc.reference.id.toString(),
                        docs: doc,
                        image: image(),
                      ),
                    ),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(22),
                    topLeft: Radius.circular(22),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Raffles",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 12.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 105,
            top: 5,
            right: 0,
            child: SizedBox(
              height: 55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    doc['name'].toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Date de sortie : ' + doc["date"],
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Prix : ' + doc['prix'].toString() + "€" ?? 'hlleo',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('sneakers')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          return ListView.builder(
            itemExtent: 90.0,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) =>
                _buildListRaffles(context, snapshot.data.docs[index]),
          );
        });
  }
}
