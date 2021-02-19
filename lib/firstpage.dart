import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mystore/widgets/signup.dart';
import 'package:provider/provider.dart';
import 'package:mystore/provider/signin_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mystore/widgets/background_painter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mystore/widgets/loggedin.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  Stream<User> _stateStream;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    try {
      _stateStream = FirebaseAuth.instance.authStateChanges();
      _stateStream.listen((event) {
        print(event);
      });
    } catch (e) {
      print('FirebaseError:');
      print(e.message);
    }

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder(
            stream: _stateStream,
            builder: (context, snapshot) {
              final provider = Provider.of<GoogleSignInProvider>(context);

              if (provider.isSigninIn) {
                return buildLoading();
              } else if (provider.isLoggedIn) {
                return LoggedInWidget();
              } else {
                return SignUpWidget();
              }
            }),
      ),
    );
  }
}

Widget buildLoading() {
  return Stack(
    fit: StackFit.expand,
    children: [
      CustomPaint(painter: BackgroundPainter()),
      Center(
        child: CircularProgressIndicator(),
      )
    ],
  );
}
