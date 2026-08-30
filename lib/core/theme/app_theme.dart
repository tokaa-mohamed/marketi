import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF1B254B),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF1B254B)),
      titleTextStyle: TextStyle(color: Color(0xFF1B254B), fontSize: 18),
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1B254B),
      surface: Colors.white,
      onSurface: Color(0xFF1B254B), // لون النصوص العام في الثيم الفاتح
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF1B254B),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0F172A),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white), // الأيقونات بيضاء في الدارك
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 18), // النصوص بيضاء في الدارك
    ),
    iconTheme: const IconThemeData(
      color: Colors.white, // جعل الأيقونات العامّة بيضاء في الوضع الداكن
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF1B254B),
      surface: Color(0xFF1E293B),
      onSurface: Colors.white, // لضمان أن كل النصوص الافتراضية أصبحت بيضاء
    ),
  );
}