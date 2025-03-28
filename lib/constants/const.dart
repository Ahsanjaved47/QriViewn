import 'package:flutter/material.dart';

var KElevatedButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.blue[900],
  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  ),
);

const KLoginTextStyle =  TextStyle(fontSize: 18, color: Colors.white);

const KForgetPassStyle = TextStyle(color: Colors.blue);

var KSplashElevatedButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.blue[900],
  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  ),
);

const KSignUpTextStyle =  TextStyle(fontSize: 18, color: Colors.white);

const NotAMemberStyle = TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold);

const KAddIconStyle = Icon(Icons.add, color: Colors.red, size: 30,);

const KTitleStyle = TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold,);

const KCurrentLocationStyle = const TextStyle(fontSize: 14, color: Colors.white70,);

const KDeleteButtonStyle = const Icon(Icons.delete, color: Colors.red);

const KMapButtonStyle = const Icon(Icons.map, color: Color(0xFF4CAF50));