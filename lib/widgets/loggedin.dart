import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoggedInWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Container(
        alignment: Alignment.center,
        color: Colors.blueGrey.shade300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Logged In', style: TextStyle(color: Colors.white)),
            SizedBox(height: 8),
            CircleAvatar(
              maxRadius: 25,
              backgroundImage: NetworkImage(user.photoURL),
            ),
            SizedBox(height: 8),
            Text('Name: ${user.displayName}',
                style: TextStyle(color: Colors.white)),
            SizedBox(height: 8),
            Text('Email: ${user.email}', style: TextStyle(color: Colors.white)),
            SizedBox(height: 8),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/homepage');
                },
                child:
                    Text('Visit Store', style: TextStyle(color: Colors.white)))
          ],
        ));
  }
}
