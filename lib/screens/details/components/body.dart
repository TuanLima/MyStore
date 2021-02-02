import 'package:flutter/material.dart';
import 'package:mystore/model/fooditem.dart';
import 'add_to_cart.dart';
import 'counter_with_fav_btn.dart';
import 'description.dart';
import 'product_title_with_image.dart';

class Body extends StatelessWidget {
  final FoodItem foodItem;

  const Body({Key key, this.foodItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.12,
                    left: 20,
                    right: 20,
                  ),
                  // height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white, //Themes.lightBrown
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 25),
                      Description(
                        foodItem: foodItem,
                      ),
                      SizedBox(height: 10),
                      CounterWithFavBtn(),
                      SizedBox(height: 10),
                      AddToCart(
                        foodItem: foodItem,
                      )
                    ],
                  ),
                ),
                ProductTitleWithImage(foodItem: foodItem)
              ],
            ),
          )
        ],
      ),
    );
  }
}
