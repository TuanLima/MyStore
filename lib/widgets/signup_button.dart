import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mystore/const/themeColor.dart';
import 'package:provider/provider.dart';
import 'package:mystore/provider/signin_provider.dart';

class GoogleSignUpButtonWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: OutlineButton.icon(
        label: Text(
          'Entrar com Google',
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
        icon: FaIcon(FontAwesomeIcons.google, color: Themes.orange),
        onPressed: () {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.login(context);
          print('backfrom login');
        },
      ),
    );
  }
}
