import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:musicapps/models/trackModel.dart';
import 'package:musicapps/pages/requestAPI.dart';
import 'pages/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // HttpHelper httpHelper = HttpHelper();

  // // Mengambil data dari API
  // List<Track>? tracks = await httpHelper.getTracks();

  // // Menampilkan hasil
  // if (tracks != null) {
  //   for (var track in tracks) {
  //     if (track.track.isNotEmpty) {
  //       print("Track Title: ${track.track[0]['title']}");
  //       // Tambahkan kode untuk menampilkan data trek sesuai kebutuhan
  //     } else {
  //       print("No tracks available for this item.");
  //     }
  //   }
  // } else {
  //   print("Failed to fetch tracks from API.");
  // }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Musik App',
      theme: ThemeData(
          textTheme: GoogleFonts.dosisTextTheme(Theme.of(context).textTheme),
          primarySwatch: Colors.lightGreen),
      initialRoute: '/login',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => LoginPage(),
      },
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
            ]),
      ),
    );
  }
}
