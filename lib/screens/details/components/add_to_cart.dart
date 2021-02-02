import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mystore/bloc/cartListBloc.dart';
import 'package:mystore/const/themeColor.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mystore/model/fooditem.dart';

import '../../../cart.dart';

class AddToCart extends StatelessWidget {
  final FoodItem foodItem;
  AddToCart({Key key, this.foodItem}) : super(key: key);

  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
  addToCart(FoodItem foodItem) {
    bloc.addToList(foodItem);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Themes.darkBrown,
              ),
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/add_to_cart.svg",
                color: Colors.black,
              ),
              onPressed: () async {
                List<FoodItem> foodItems = await bloc.listStream.first;
                addToCart(foodItem);
                final snackBar = SnackBar(
                  content: Text('${foodItem.title} adicionado ao Carrinho'),
                  duration: Duration(milliseconds: 550),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: Themes.darkerBrown,
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Cart()));
                },
                child: Text(
                  "Finalizar Compra".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
