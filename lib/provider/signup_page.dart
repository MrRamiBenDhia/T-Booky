import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  void showAlert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final phoneController = TextEditingController();
    Future addUserDetails(
      String uid,
      String firstName,
      String lastName,
      String email,
      String phone,
    ) async {
      await FirebaseFirestore.instance.collection('user').doc(uid).set({
        'uid': uid,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
      });
    }

    Future signUp() async {
      //todo add condition passwordConfirmed
      if (true) {
        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

          // The new user's UID can be accessed from the UserCredential object.
          String? userUid = userCredential.user?.uid;

          // Now you can use the userUid for further operations or to store it in your database.

          addUserDetails(
            userUid!,
            firstNameController.text.trim(),
            lastNameController.text.trim(),
            emailController.text.trim(),
            phoneController.text.trim(),
          );
        } catch (e) {
          showAlert();
          // Handle any errors that may occur during user creation.
        }
        Navigator.pop(context);
      }
    }

    @override
    // ignore: unused_element
    void dispose() {
      emailController.dispose();
      passwordController.dispose();
      firstNameController.dispose();
      lastNameController.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.ads_click_rounded,
                size: 100,
              ),
              const SizedBox(height: 80),
              const Text(
                'Hello There',
                // style: GoogleFonts.bebasNeue(fontSize: 69),
              ),
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Email',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ), // InputDecoration
                ), // TextField
              ), // Padding
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Password',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ), // InputDecoration
                ), // TextField
              ), // Padding
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Name',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ), // InputDecoration
                ), // TextField
              ), // Padding
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Last Name',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ), // InputDecoration
                ), // TextField
              ), // Padding
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Phone',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ), // InputDecoration
                ), // TextField
              ), // Padding
              const SizedBox(height: 10),
              ElevatedButton(onPressed: signUp, child: const Text("Confirm"))
            ],
          ),
        ),
      ),
    );
  }
}
