import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mystore/const/themeColor.dart';
import 'package:mystore/model/fooditem.dart';

class ProductTitleWithImage extends StatelessWidget {
  final FoodItem foodItem;
  const ProductTitleWithImage({Key key, this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Text(
            foodItem.category[0],
            style: TextStyle(
                color: Colors.white, fontFamily: GoogleFonts.lato().fontFamily),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            foodItem.title,
            style: Theme.of(context).textTheme.headline4.copyWith(
                color: Colors.white), //, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  SizedBox(
                    height: 140,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Preço\n",
                            style: TextStyle(color: Themes.darkerBrown)),
                        TextSpan(
                          text: "R\$${foodItem.price.toStringAsFixed(2)}",
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Themes.darkerBrown, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10),
              Expanded(
                child: Hero(
                  tag: "${foodItem.id}",
                  child: Image.network(
                    foodItem.imgUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
