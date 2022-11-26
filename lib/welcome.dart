import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';


class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [SizedBox(height: 100,),
            
            RaisedButton(onPressed: (){ FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Login()));

            } ,
            child: Text('signout'),
            ),

            Container(
              child: Text('Welcome'),
            ),
          ],
        ),
      ),
    );
  }
}
