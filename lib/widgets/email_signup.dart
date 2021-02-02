import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mystore/const/themeColor.dart';

class EmailSignUpButtonWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: OutlineButton.icon(
        label: Text(
          'Entrar com Email',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Themes.darkerBrown),
        ),
        shape: StadiumBorder(),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        highlightedBorderColor: Themes.darkerBrown,
        borderSide: BorderSide(color: Themes.darkerBrown),
        textColor: Themes.darkerBrown,
        icon: FaIcon(Icons.local_post_office, color: Themes.orange),
        onPressed: () {
          print('LoggedIn With Email called');
        },
      ),
    );
  }
}
