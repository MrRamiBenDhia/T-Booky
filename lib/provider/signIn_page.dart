// // ignore: file_names
// import 'dart:js_interop';

import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:t_booky/main.dart';
import 'package:t_booky/provider/forgot_password_page.dart';
import 'package:t_booky/provider/signup_page.dart';
// import 'package:classy/widget/component/my_icon_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';
import 'package:t_booky/screens.dart/splashsceen.dart';

import 'google_signin.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final mailController = TextEditingController();
  final passwordController = TextEditingController();

  void showAlert(QuickAlertType type , String e) {
    QuickAlert.show(
      context: context,
      type: type,
      text: e,
    );
  }

  Future<void> SignInUser() async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: mailController.text.trim(),
              password: passwordController.text.trim());
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
            // builder: (context) => MyHomePage(title: 'T-Booky'),
            builder: (context) => splashscreen(),
          ));
      showAlert(QuickAlertType.success,'Welcome');
    } catch (e) {
      showAlert(QuickAlertType.error ,e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in Page'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.lock,
              size: 100,
            ),
            const SizedBox(height: 50),
            const Text(
              'Welcome Back!',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: mailController,
                decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
              ),
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const ForgotPasswordPage();
                        },
                      ));
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            GestureDetector(
              onTap: () => SignInUser(),
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey[200],
                    ),
                  ),
                  Text(
                    'or Continue with',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey[200],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogin();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignInPage()),
                      );
                    },
                    child: MyIconButton(
                        imagePath: 'assets/images/google-logo.png')),
                SizedBox(width: 20),
                GestureDetector(
                    onTap: () {},
                    child: MyIconButton(
                        imagePath: 'assets/images/apple-logo.png')),
                SizedBox(width: 20),
                GestureDetector(
                    onTap: () {},
                    child: MyIconButton(
                        imagePath: 'assets/images/facebook-logo2.png')),
              ],
            ),
            // ElevatedButton(
            //   onPressed: () => SignInUser(),
            //   child: const Text('Sign IN'),
            // ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpPage(
                          // className: 'Class Num 78',
                          )),
                );
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  Widget MyIconButton({required String imagePath}) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Image.asset(
        imagePath,
        height: 50,
      ),
    );
  }
}
