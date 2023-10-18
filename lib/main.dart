import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:facia_mobilesdk/facia_mobilesdk.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'OpenSans'),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, Object> configObj = {
    // "showConsent": false,
    // "showVerificationType": false
  };

  /*
   * This function sends call to the Facia's flutter plugin
   * and receives the response in a variable
   */

  Future<void> initPlatformState() async {
    String response = "";
    try {
      response = await FaciaSdk.sendRequest(
          token: 'sbdashdbashkdbasjhdasjd', configObject: configObj);
      var object = jsonDecode(response);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(object.toString()),
      ));

      print(object.toString());
      print(object["event"].toString());
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
  }

  /*
   * Click listener to start the SDK flow
   */

  void continueFun() {
    var v = DateTime.now();
    var reference = "package_sample_Flutter_$v";
    initPlatformState();
  }

  /*
   * UI of demo application
   */

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 200.0,
              height: 50.0,
              margin: EdgeInsets.only(bottom: 40.0),
              child: OutlinedButton(
                onPressed: continueFun,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Color(0xFF007BFF), // Use hex color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  "Open Facia SDK",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
}
