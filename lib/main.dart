import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, Color> colors = {
    "purple": Colors.purple,
    "blue": Colors.blue,
    "yellow": Colors.yellow,
    "pink": Colors.pink,
    "teal": Colors.teal,
    "orange": Colors.orange,
  };
  Color? selectedColor;
  @override
  void initState() {
    getStoredColor();
    super.initState();
  }

  void getStoredColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? color = prefs.getString("color");
    setState(() {
      selectedColor = colors[color];
    });
  }

  void setColor(String colorName, Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("color", colorName);
    setState(() {
      selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Five Apps',
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: selectedColor,
            title: const Text('Five Apps'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text("Tu sistema operativo es: ${kIsWeb ? "Web": Platform.operatingSystem}"),
              ),
              for (var color in colors.entries)
                Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      child: Text(color.key),
                      onPressed: () => setColor(color.key, color.value),
                      style: ElevatedButton.styleFrom(
                          primary: color.value, minimumSize: const Size(300, 60)),
                    ))
            ],
          )),
    );
  }
}
