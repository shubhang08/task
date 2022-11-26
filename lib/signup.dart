
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './login.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import './welcome.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);


  @override
  _signupState createState() => _signupState();
}

final _formKey = GlobalKey<FormState>();


TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

Future<FirebaseApp> _initializeFirebase() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  return firebaseApp;
}

class  _signupState extends State<signup> {
  static Future<User?> SignupUsingEmailPassword(
      {required String email, required password, required BuildContext}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      print('2');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('no User found with that email');
      }
    }
    return user;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Text('Sign Up',
                          style: GoogleFonts.pacifico(
                            textStyle: const TextStyle(
                              color: Colors.purpleAccent,
                              decoration: TextDecoration.underline,
                              fontSize: 50,
                              fontWeight: FontWeight.w400,
                            ),
                          ))),
                  SizedBox(height: MediaQuery.of(context).size.height*0.0025,),
                  Container(
                    child: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[

                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width*0.9,
                          height: MediaQuery.of(context).size.height*0.059,
                          decoration: BoxDecoration(

                            border: const Border(
                              top: BorderSide(width: 1.0, color: Colors.black54),
                              left: BorderSide(width: 1.0, color: Colors.black54),
                              right: BorderSide(width: 1.0, color: Colors.black54),
                              bottom: BorderSide(width: 1.0, color: Colors.black54),
                            ),
                            borderRadius: BorderRadius.circular(5),

                            boxShadow: [BoxShadow( color: Colors.white12,blurRadius: 6 ,offset: Offset(0, 2),)],

                          ),

                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              label: Text('Email'),
                              hintText: 'abc@xyz.com',
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.0025,),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width*0.9,
                          height: MediaQuery.of(context).size.height*0.059,
                          decoration: BoxDecoration(

                            border: const Border(
                              top: BorderSide(width: 1.0, color: Colors.black54),
                              left: BorderSide(width: 1.0, color: Colors.black54),
                              right: BorderSide(width: 1.0, color: Colors.black54),
                              bottom: BorderSide(width: 1.0, color: Colors.black54),
                            ),
                            borderRadius: BorderRadius.circular(5),

                            boxShadow: [BoxShadow( color: Colors.white12,blurRadius: 6 ,offset: Offset(0, 2),)],

                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              label: Text('Password'),
                              prefixIcon: Icon(Icons.lock),
                            ),
                          ),
                        ),

                        Container(
                          child: FutureBuilder(
                              future: _initializeFirebase(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return RaisedButton(
                                    child: const Text(
                                      'Submit',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () async {
                                      User? user = await SignupUsingEmailPassword(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                          BuildContext: context);
                                      if (user != null) {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) => Welcome()
                                            )
                                        );
                                        print(user);
                                      }
                                    },
                                    padding: EdgeInsets.all(12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    color: Colors.purpleAccent,
                                  );
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                          ),
                        ),
                        Container(
                          child: FlatButton(
                            child: const Text(
                              'Already have a account? Login',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.underline),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) => Login()));
                            },
                          ),
                        )
                      ]),
                    ),
                  )
                ],
              )),
        ));
  }
}