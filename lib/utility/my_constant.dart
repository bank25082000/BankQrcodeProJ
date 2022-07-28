import 'package:flutter/material.dart';

class MyConstant {
  static Color primary = Color.fromARGB(255, 165, 221, 11); //สีของบาร์
  static Color dark = Color.fromARGB(255, 10, 10, 10); //สีของตัวอักษร
  static Color light = Color.fromARGB(255, 63, 223, 132); //สีของตัวที่ไฮไลท์
  static Color active = Color.fromARGB(255, 185, 32, 185); //สีของตัวสิ่งที่คลิกได้
  static Color white = Colors.white; //สีของบนปุ่ม

  TextStyle h1Style() => TextStyle(
        fontSize: 36,
        color: dark,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => TextStyle(
        fontSize: 20,
        color: dark,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );

  TextStyle h3ActiveStyle() => TextStyle(
        fontSize: 20,
        color: active,
        fontWeight: FontWeight.w500,
      );

  TextStyle h3ButtonStyle() => TextStyle(
        fontSize: 16,
        color: white,
        fontWeight: FontWeight.w500,
      );
}
