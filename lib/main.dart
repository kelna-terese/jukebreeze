import 'package:flutter/material.dart';
import 'package:jukebreeze/homepage.dart';

void main() {
  runApp(JukeBreezeApp());
}

class JukeBreezeApp extends StatefulWidget {
  @override
  _JukeBreezeAppState createState() => _JukeBreezeAppState();
}

class _JukeBreezeAppState extends State<JukeBreezeApp> {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: JukeBreezeHomePage(
        isDarkTheme: isDarkTheme,
        onThemeChanged: (value) => setState(() => isDarkTheme = value),
      ),
    );
  }
}