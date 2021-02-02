import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mystore/bloc/cartListBloc.dart';
import 'package:mystore/const/themeColor.dart';
import 'package:mystore/model/fooditem.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({Key key, this.foodItem}) : super(key: key);

  final FoodItem foodItem;
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: Themes.darkerBrown,
      appBar: buildAppBar(context),
      body: Body(foodItem: foodItem),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Themes.orange,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/back.svg',
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/search.svg"),
          onPressed: () {},
        ),
        Stack(children: [
          IconButton(
            icon: SvgPicture.asset("assets/cart.svg"),
            onPressed: () {},
          ),
          Positioned(
            right: 3,
            top: 4,
            child: StreamBuilder(
              stream: bloc.listStream,
              builder: (context, snapshot) {
                List<FoodItem> foodItems = snapshot.data;
                int length = foodItems != null ? foodItems.length : 0;
                return Container(
                  child: Text(
                    length.toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                  decoration: BoxDecoration(
                      color: Themes.orange,
                      borderRadius: BorderRadius.circular(50)),
                );
              },
            ),
          )
        ]),
        SizedBox(width: 10),
      ],
    );
  }
}
