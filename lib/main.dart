/**
 * Author         : Nursyafiah binti Zahari
 * Program        : Loan and Penalty Application
 * Date Created   : 21 December 2023
 * Date Modifeid  : None
 * Purpose        : The application that will populate about the penalty and list of books
 * Changes        : None
 */
import 'package:flutter/material.dart';
import 'package:loan_penalty/widget/book_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyAppState(),
    );
  }
}

class MyAppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100], // Background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              width: 200, // Small size for the logo
              height: 150, // Small size for the logo
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to Perpustakaan Sultanah Nur Zahirah',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo[800],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => bookList()),
                );
              },
              child: Text('Click here'),
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue[900],
                onPrimary: Colors.white, // Gesture splash
              ),
            ),
          ],
        ),
      ),
    );
  }
}
