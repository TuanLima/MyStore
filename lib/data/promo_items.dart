import 'package:flutter/material.dart';

const List<PromoItem> promoItemList = [
  PromoItem(
      title: "",
      url:
          "https://www.portalimpactto.com.br/wp-content/uploads/2020/03/conheca-a-brasil-cacau-a-loja-mais-aconchegante-e-doce-da-cidade.jpg"),
  PromoItem(
      title: "",
      url:
          "https://www.riopretoshopping.com.br/thumb/media/gastronomias/06/02/chocolates-brasil-cacau.jpg__w470_h330"),
  PromoItem(
      title: "",
      url:
          "https://acontecendoaqui.com.br/sites/default/files/brasil_cacau.jpg"),
  PromoItem(
      title: "",
      url:
          "https://www.franquialucrativa.blog.br/wp-content/uploads/loja-brasil-cacau.jpg")
];

class PromoItem extends StatelessWidget {
  final String title;
  final String url;

  const PromoItem({this.title, this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Image.network(url),
        ),
      ),
    );
  }
}
