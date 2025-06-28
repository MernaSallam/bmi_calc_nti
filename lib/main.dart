import 'package:flutter/material.dart';

import 'features/BMI_Calc/presentation/UI_Screens/firstScreen.dart';

//import 'Screens/secndScreen.dart';

void main() {
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
      //color: Color.fromARGB(255, 70, 109, 200),
      home: const FirstPage(),
    );
  }
}
