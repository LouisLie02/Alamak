import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicapps/main.dart';
import 'package:musicapps/models/MyAnalyticsHelper.dart';
import 'package:musicapps/models/authentication.dart';
import 'package:musicapps/pages/home.dart';
import 'register.dart';
import 'package:musicapps/models/database.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  MyAnalyticsHelper fbAnalytics = MyAnalyticsHelper();
  final DatabaseHelper dbHelper = DatabaseHelper();
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
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintStyle: TextStyle(color: Colors.white),
                  errorStyle: TextStyle(color: Colors.red),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintStyle: TextStyle(color: Colors.white),
                  errorStyle: TextStyle(color: Colors.red),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  final email = emailController.text;
                  final password = passwordController.text;
                  // Offline
                  // try {
                  //   final user =
                  //       await dbHelper.getUserByPassword(email, password);

                  //   if (user != null &&
                  //       user.password == password &&
                  //       user.email == email) {
                  //     // fbAnalytics.testAllEventTypes();
                  //     fbAnalytics.analytics.logLogin();
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(
                  //         content: Text('Login Berhasil!'),
                  //       ),
                  //     );
                  //     Navigator.of(context).pushReplacementNamed('/');
                  //   } else {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(
                  //         content: Text(
                  //             'Login Gagal: Email atau password tidak valid.'),
                  //         backgroundColor: Colors.red,
                  //       ),
                  //     );
                  //   }
                  // } catch (e) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text('Terjadi kesalahan: $e'),
                  //       backgroundColor: Colors.red,
                  //     ),
                  //   );
                  // }

                  //Online
                  try {
                    String? userId =
                        await AuthFirebase().login(email, password);

                    if (userId != null) {
                      // Login successful
                      fbAnalytics.analytics.logLogin();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Login Berhasil!'),
                        ),
                      );
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomePage(
                                email: email,
                              )));
                    } else {
                      // Login failed
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Login Gagal: Email atau password tidak valid.',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Terjadi kesalahan: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  elevation: 2,
                ),
                child: Text('Login', style: TextStyle(fontSize: 18.0)),
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
                child: Text('Belum punya akun? Daftar di sini',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
