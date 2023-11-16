import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicapps/models/MyAnalyticsHelper.dart';
import 'package:musicapps/models/authentication.dart';
// import 'package:musicapps/models/database.dart';
// import 'package:musicapps/models/user.dart';
import 'home.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  MyAnalyticsHelper signUpAnalytics = MyAnalyticsHelper();
  // final DatabaseHelper dbHelper = DatabaseHelper();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(email);
  }

  bool isStrongPassword(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]'));
  }

  Future<void> _showSnackBar(String message) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Registrasi'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    prefixIcon: Icon(Icons.person, color: Colors.white),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email, color: Colors.white),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: Colors.white),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    final name = nameController.text;
                    final email = emailController.text;
                    final password = passwordController.text;

                    if (isValidEmail(email) && isStrongPassword(password)) {
                      try {
                        String? userId =
                            await AuthFirebase().signUp(email, password);

                        if (userId != null) {
                          // Registration successful
                          signUpAnalytics.analytics
                              .logSignUp(signUpMethod: 'Daftar Akun Berhasil');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Registrasi Berhasil: Akun Anda telah berhasil didaftarkan.',
                              ),
                            ),
                          );

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        } else {
                          // Registration failed
                          _showSnackBar('Registrasi Gagal: Terjadi kesalahan.');
                        }
                      } catch (e) {
                        // Handle other registration errors
                        _showSnackBar('Registrasi Gagal: $e');
                      }
                    } else {
                      _showSnackBar(
                          'Registrasi Gagal: Email atau password tidak valid.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    elevation: 2,
                  ),
                  child: Text('Daftar', style: TextStyle(fontSize: 18.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
