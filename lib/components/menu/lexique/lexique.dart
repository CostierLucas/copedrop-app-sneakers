import 'package:flutter/material.dart';
import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';

class Lexique extends StatefulWidget {
  Lexique({Key key}) : super(key: key);

  @override
  _Lexique createState() => _Lexique();
}

class _Lexique extends State<Lexique> {
  Widget build(BuildContext context) {
    List<String> list = [
      'ATC : Ajouter au panier',
      "Bot : Robot pour faciliter l'achat",
      "Cop : Acheter ",
      "Drop : Passer une release",
      "Dead Stock : Sneakers neuve",
      "DSWT : Sneakers neuve avec étiquettes",
      "Flake : Personne qui ne tient pas son engagement lors d'une vente",
      "General Release : Sneakers qui sont distribués en grande quantité",
      "Legit : Fiable",
      "Last Pick Up (LPU) : Dernier achat de sneakers",
      "Raffle: Tirage au sort",
      "Retail : Prix de vente en magasin",
      "Want to buy (wtb) : Vouloir acheter des sneakers",
      "Want to sell (wts): Vouloir vendre des sneakers",
      "Want to trade (wtt): Echange de sneakers"
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[500],
        title: Text("Lexique"),
      ),
      body: SafeArea(
        child: Scrollbar(
          child: AlphabetScrollView(
            list: list.map((e) => AlphaModel(e)).toList(),
            itemExtent: 50,
            itemBuilder: (_, k, id) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: ListTile(
                  title: Text('$id'),
                  leading: Icon(Icons.label),
                ),
              );
            },
            waterMark: (value) => Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              alignment: Alignment.center,
              child: Text(
                '$value'.toUpperCase(),
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
