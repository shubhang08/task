import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:task/signup.dart';
import './welcome.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);


  @override
  _LoginState createState() => _LoginState();
}

final _formKey = GlobalKey<FormState>();


TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

Future<FirebaseApp> _initializeFirebase() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  return firebaseApp;
}

class _LoginState extends State<Login> {

  static Future<User?> loginUsingEmailPassword(
      {required String email, required password, required BuildContext}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
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
                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                  Container(
                    child: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[


                        Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          height: MediaQuery.of(context).size.height*0.059,
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(10),

                          decoration: BoxDecoration(
                            border: const Border(
                              top: BorderSide(width: 1.0, color: Colors.black54),
                              left: BorderSide(width: 1.0, color: Colors.black54),
                              right: BorderSide(width: 1.0, color: Colors.black54),
                              bottom: BorderSide(width: 1.0, color: Colors.black54),
                            ),

                            borderRadius: BorderRadius.circular(5),


                            boxShadow: [BoxShadow( color: Colors.white12,blurRadius: 4 ,offset: Offset(0, 2),)],

                          ),
                          child: TextFormField(
                            cursorWidth: MediaQuery.of(context).size.width*0.004,


                            controller: _emailController,

                            decoration: const InputDecoration(
                              label: Text('Email'),
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.email),

                            ),

                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*.003 ,),
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
                              //filled: true,
                              label: Text('Password'),
                              prefixIcon: Icon(Icons.lock),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: FutureBuilder(
                              future: _initializeFirebase(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return RaisedButton(
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () async {

                                      User? user = await loginUsingEmailPassword(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                          BuildContext: context);

                                      if (user != null) {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>Welcome()));
                                        print(user);
                                      }
                                      else{
                                        AlertDialog(title: Text("Sample Alert Dialog"));
                                      }
                                    },
                                    padding: EdgeInsets.all(12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    color: Colors.purpleAccent,
                                  );
                                }
                                return const Center(child: CircularProgressIndicator(),);
                              }
                          ),
                        ),
                        Container(
                          child: FlatButton(
                            child: Text(
                              'Don\'t have a account?SignUp',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.underline),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) => signup()));
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