import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:training_memorizer/screens/home_screen.dart';
import 'package:training_memorizer/service/single.dart';
import 'firebase_options.dart'; // Import this file

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Use the generated options
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Training Memorizer v ${UserSingleton.instance.version}',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(
          primary: Colors.deepPurpleAccent,
          secondary: Colors.purpleAccent,
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold), // Updated headline6
          bodyMedium: TextStyle(color: Colors.white70, fontSize: 16), // Updated bodyText2
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: Colors.deepPurpleAccent,
            textStyle: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
