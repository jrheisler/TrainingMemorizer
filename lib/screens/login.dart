import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../service/single.dart';
import 'main_screen.dart';

void showAuthDialog(BuildContext context) {
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool isRegisterMode = false;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(
              isRegisterMode ? "Register" : "Login",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  onChanged: (value) => email = value,
                  decoration: const InputDecoration(labelText: 'Email'),
                  autofillHints: const [AutofillHints.email],
                ),
                TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  onChanged: (value) => password = value,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  autofillHints: const [AutofillHints.password],
                ),
                if (isRegisterMode)
                  TextField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    onChanged: (value) => confirmPassword = value,
                    decoration:
                        const InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    autofillHints: const [AutofillHints.newPassword],
                  ),
                if (!isRegisterMode) // Show "Forgot Password" only in login mode
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () async {
                        if (email.isNotEmpty) {
                          try {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: email);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Password reset email sent"),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } catch (e) {
                            print("Error: ${e.toString()}");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Error: ${e.toString()}"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter your email"),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        }
                      },
                      child: const Text("Forgot Password?"),
                    ),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    isRegisterMode = !isRegisterMode;
                  });
                },
                child: Text(
                  isRegisterMode ? "Login Instead" : "Create Account",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final FirebaseAuth auth = FirebaseAuth.instance;

                  if (isRegisterMode) {
                    // Registration logic with password confirmation
                    if (password == confirmPassword) {
                      try {
                        UserCredential userCredential =
                            await auth.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        User firebaseUser = userCredential.user!;
                        UserSingleton.instance.setFirebaseUser(firebaseUser);

                        TrainingUser newUser = TrainingUser(
                          userName: email.split('@')[0],
                          email: email,
                          token: firebaseUser.uid,
                          lastLogin: DateTime.now(),
                          companyName: '',
                          phoneNumber: '',
                          role: 'student',
                        );

                        UserSingleton.instance.setAPIUser(newUser);

                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(firebaseUser.uid)
                            .set({
                          'userName': newUser.userName,
                          'email': newUser.email,
                          'lastLogin': newUser.lastLogin,
                          'companyName': newUser.companyName,
                          'phoneNumber': newUser.phoneNumber,
                          'role': newUser.role,
                        });

                        //Navigate to the main screen on successful registration
                        Navigator.pushReplacement(
                           context,
                           MaterialPageRoute(builder: (context) => MainScreen()),
                        );
                      } catch (e) {
                        print("Error: ${e.toString()}");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error: ${e.toString()}")),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Passwords do not match")),
                      );
                    }
                  } else {
                    try {
                      UserCredential userCredential =
                          await auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      User firebaseUser = userCredential.user!;
                      UserSingleton.instance.setFirebaseUser(firebaseUser);

                      DocumentSnapshot userDoc = await FirebaseFirestore
                          .instance
                          .collection('users')
                          .doc(firebaseUser.uid)
                          .get();

                      // List<ApiRecord> apiRecords = (userDoc['apiRecords'] as List<dynamic>)
                      //     .map((record) => ApiRecord.fromJson(record as Map<String, dynamic>))
                      //     .toList();

                      TrainingUser existingUser = TrainingUser(
                        userName: userDoc['userName'],
                        email: userDoc['email'],
                        token: firebaseUser.uid,
                        lastLogin: userDoc['lastLogin'].toDate(),
                        companyName: userDoc['companyName'],
                        phoneNumber: userDoc['phoneNumber'],
                        role: userDoc['role'],
                      );

                      UserSingleton.instance.setAPIUser(existingUser);

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(firebaseUser.uid)
                          .update({
                        'lastLogin': DateTime.now(),
                      });

                      // Navigate to the main screen on successful login
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    } catch (e) {
                      print("Error: ${e.toString()}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: ${e.toString()}")),
                      );
                    }
                  }
                },
                child: Text(isRegisterMode ? "Register" : "Login"),
              ),
            ],
          );
        },
      );
    },
  );
}
