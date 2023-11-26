import 'dart:io';
import 'dart:isolate';

import 'package:alarm_app/setTime.dart';
import 'package:flutter/material.dart';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_tts/flutter_tts.dart';


@pragma('vm:entry-point')
speakCurrentTime() async {

  FlutterTts flutterTts = FlutterTts();
  DateTime now = DateTime.now();
  String currentTime = "${now.hour} ${now.minute}";

  await flutterTts.speak("The current time is $currentTime");
  print("completed");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

            SetTime(),


          ElevatedButton(
            onPressed: () async {
              AndroidAlarmManager.cancel(0);
            },
            child: Text("stop alarm"),
          )
        ],
      ),
    ));
  }
}
