import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:lottie/lottie.dart';
import 'package:photo_check/Api/ApiURL.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:photo_check/dashboard.dart';
import 'package:photo_check/shared%20Prefrences/Sharedprefrences.dart';

// import 'SessionManagement/SharedPreferenceHelper.dart';

// ************************** LOGIN SCREEN **************************


Future<void> saveSession(String name,String userId,String userRole,String email,String isLoggedIn) async {
    UserSharedPreferences userSharedPreferences=UserSharedPreferences();
  await userSharedPreferences.saveUserData(name, userId, userRole, email, isLoggedIn);
}

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  bool _obscurePassword = true;
  // ignore: unused_field
  bool _isLoading = false;
  String URL = ApiURL.getURL();
  bool isLoginpage = true;

  Future<bool> loginUser() async {
    setState(() {
      _isLoading = true;
    });

    // final String url = "https://hietccsu.org/Api/login.php";
    String uri = '${URL}login.php';
    try {
      final response = await http.post(
        Uri.parse(uri),
        body: {
          "email": emailCtrl.text,
          "password": passCtrl.text,
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // print(data);
        if (data["status"] == true) {
          // await SharedPreferenceHelper.saveUserLoggedIn(true);
          // await SharedPreferenceHelper.saveUserEmail(emailCtrl.text);
          print("Login Success: ${data['data']}");
          await  saveSession(data['data']['name'],data['data']['id'].toString(),data['data']['role'],
              data['data']['email'],(DateTime.now()).toString());

          setState(() {
            _isLoading = false;
          });
          return true;
          // Navigate to the next screen or handle user session
        } else {
          _showMessage("Login Failed: ${data['message']}");
        }
      } else {
        _showMessage("Server error. Please try again later.");
      }
    } catch (e) {
      _showMessage("Error: $e");
    }

    setState(() {
      _isLoading = false;
    });
    return false;
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/warning.png', height: 80),
                // Custom warning image
                const SizedBox(height: 10),
                const Text(
                  "Alert",
                  style: TextStyle(fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0057B8), Color(0xFF009688)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius
                            .circular(12)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "OK",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0057B8), Color(0xFF009688)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0057B8), Color(0xFF009688)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(1.2), // Border thickness
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Welcome icon inside the Card
                        Image.asset('assets/images/logo_hiet.jpeg', height: 150),
                        const SizedBox(height: 10),

                        // Welcome text with gradient color
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              colors: [Color(0xFF0057B8), Color(0xFF009688)],
                            ).createShader(bounds);
                          },
                          child: const Text(
                            'Welcome To Hi-Tech Institute of Engineering and Technology',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Required for ShaderMask effect
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Text fields and button
                        CustomTextField(
                          controller: emailCtrl,
                          labelText: 'Email or Username',
                          icon: Icons.email_outlined,
                        ),
                        CustomTextField(
                          controller: passCtrl,
                          labelText: 'Password',
                          icon: Icons.lock_outline,
                          obscureText: _obscurePassword,
                          isPassword: true,
                          togglePassword: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        const SizedBox(height: 15),

                        // Sign In Button
                        CustomButton(
                          text: 'Sign In',
                          gradientColors: [Color(0xFF0057B8), Color(0xFF009688)],
                          textColor: Colors.white,
                          onPressed: () async {
                            bool isSuccess = await loginUser();

                            if (isSuccess) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => Center(
                                  child: Lottie.asset(
                                    'assets/animations/Animation_lottie.json',
                                    width: 150,
                                    height: 150,
                                    repeat: false,
                                  ),
                                ),
                              );

                              await Future.delayed(const Duration(seconds: 2));
                              FocusScope.of(context).requestFocus(FocusNode());

                              if (context.mounted) {
                                Navigator.pop(context);
                              }

                              if (context.mounted) {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    transitionDuration: const Duration(milliseconds: 500),
                                    pageBuilder: (_, __, ___) => DashboardScreen(),
                                    transitionsBuilder: (_, animation, __, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              }
                            } else {
                              print("Login Failed");
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ************************** SIGN UP SCREEN **************************

// Custom TextField Widget
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool obscureText;
  final bool isPassword;
  final VoidCallback? togglePassword;

  const CustomTextField({
    required this.controller,
    required this.labelText,
    required this.icon,
    this.obscureText = false,
    this.isPassword = false,
    this.togglePassword,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.black54),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
            onPressed: togglePassword,
          )
              : null,
          labelText: labelText,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}


// Custom Gradient Button
class CustomButton extends StatelessWidget {
  final String text;
  final List<Color> gradientColors;
  final Color textColor;
  final VoidCallback onPressed;

  const CustomButton({
    required this.text,
    required this.gradientColors,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}