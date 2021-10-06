import 'package:flutter/material.dart';

// ICON RAFFLES
getLogo(String link) {
  if (link.contains('courir')) {
    return Image.asset(
      "assets/shop/courir.png",
      height: 60,
      width: 60,
    );
  } else if (link.contains('afew')) {
    return Image.asset(
      "assets/shop/afew.png",
      height: 60,
      width: 60,
    );
  } else if (link.contains('jd')) {
    return Image.asset(
      "assets/shop/jd.png",
      height: 60,
      width: 60,
    );
  } else if (link.contains('svd')) {
    return Image.asset(
      "assets/shop/svd.jpeg",
      height: 60,
      width: 60,
    );
  } else if (link.contains('sns')) {
    return Image.asset(
      "assets/shop/sns.jpeg",
      height: 60,
      width: 60,
    );
  } else if (link.contains('hanon')) {
    return Image.asset(
      "assets/shop/hanon.jpeg",
      height: 60,
      width: 60,
    );
  } else if (link.contains('naked')) {
    return Image.asset(
      "assets/shop/naked.jpeg",
      height: 60,
      width: 60,
    );
  } else if (link.contains('end')) {
    return Image.asset(
      "assets/shop/end.jpeg",
      height: 60,
      width: 60,
    );
  } else if (link.contains('b4b')) {
    return Image.asset(
      "assets/shop/b4b.png",
      height: 60,
      width: 60,
    );
  } else if (link.contains('kickz')) {
    return Image.asset(
      "assets/shop/kickz.jpeg",
      height: 60,
      width: 60,
    );
  } else if (link.contains('footshop')) {
    return Image.asset(
      "assets/shop/footshop.jpeg",
      height: 60,
      width: 60,
    );
  } else if (link.contains('adidas')) {
    return Image.asset(
      "assets/shop/adidas.jpeg",
      height: 60,
      width: 60,
    );
  } else if (link.contains('nike')) {
    return Image.asset(
      "assets/shop/snkrs.png",
      height: 60,
      width: 60,
    );
  } else if (link.contains('shinzo')) {
    return Image.asset(
      "assets/shop/shinzo.png",
      height: 60,
      width: 60,
    );
  } else if (link.contains('bstn')) {
    return Image.asset(
      "assets/shop/bstn.jpeg",
      height: 60,
      width: 60,
    );
  } else {
    return Image.asset(
      "assets/noimage.png",
      height: 60,
      width: 60,
    );
  }
}
