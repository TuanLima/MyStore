import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mystore/const/themeColor.dart';
import 'package:mystore/model/fooditem.dart';

class Description extends StatelessWidget {
  final FoodItem foodItem;
  const Description({Key key, this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, bottom: 10),
      child: Text(
        shortenedDesc(foodItem.description),
        style: TextStyle(
            height: 1.5,
            fontSize: 20,
            color: Themes.darkerBrown,
            fontFamily: GoogleFonts.lato().fontFamily),
      ),
    );
  }

  String shortenedDesc(String description) {
    if (description.length > 100) {
      return description.substring(0, 100) + '...';
    }

    return description;
  }
}
