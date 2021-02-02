import 'package:flutter/material.dart';
import 'package:mystore/widgets/background_painter.dart';
import 'package:mystore/widgets/email_signup.dart';
import 'package:mystore/widgets/signup_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:mystore/provider/signin_provider.dart';

class SignUpWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: BackgroundPainter(),
        ),
        buildSignUp(context)
      ],
    );
  }
}

Widget buildSignUp(BuildContext context) {
  double devWidth = MediaQuery.of(context).size.width;
  double devHeight = MediaQuery.of(context).size.height;
  double logoWidth = devWidth * 0.6;
  return Stack(
    children: [
      Positioned(
        left: (devWidth - logoWidth) / 2,
        bottom: devWidth * 0.05,
        child: Container(
          width: logoWidth,
          child: Image.network(
              'https://www.boulevardbigbom.com.br/wp-content/uploads/2019/03/chocolate-brasil-cacau.png'),
        ),
      ),
      Positioned(
          left: 10, top: devHeight * 0.55, child: GoogleSignUpButtonWidget()),
      Positioned(
          left: 130,
          top: devHeight * 0.55 + 70,
          child: EmailSignUpButtonWidget()),
    ],
  );
}

Widget googleSignOutButtonWidget(BuildContext context) {
  return OutlineButton.icon(
    label: Text(
      'SignOut of Google',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
    shape: StadiumBorder(),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    highlightedBorderColor: Colors.black,
    borderSide: BorderSide(color: Colors.black),
    textColor: Colors.black,
    icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
    onPressed: () {
      final provider =
          Provider.of<GoogleSignInProvider>(context, listen: false);
      provider.logout();
      print('backfrom login');
    },
  );
}

// class TestButtonWidget extends StatelessWidget {
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 70,
//           width: 70,
//           decoration: BoxDecoration(
//             border: Border.all(color: Themes.darkerBrown),
//             shape: BoxShape.circle,
//           ),
//           padding: EdgeInsets.all(4),
//           child: RaisedButton(
//             shape: RoundedRectangleBorder(borderRadius: Bp),
//             child: FaIcon(FontAwesomeIcons.inbox, color: Colors.red),
//             onPressed: () {
//               // final provider =
//               //     Provider.of<GoogleSignInProvider>(context, listen: false);
//               // provider.login(context);
//               print('LoggedIn With Email called');
//             },
//           ),
//         ),
//         Text(
//           'Entrar com Email',
//           style: TextStyle(fontFamily: GoogleFonts.lato().fontFamily),
//         ),
//       ],
//     );
//   }
// }
