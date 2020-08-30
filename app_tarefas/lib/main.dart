import 'package:app_tarefas/screens/HomeScreen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
              borderSide: BorderSide(color: Colors.indigo)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(3.0)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
              borderSide: BorderSide(color: Colors.indigo)),
          hintStyle: TextStyle(color: Colors.indigo),
        ),
        hintColor: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
