import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_check/RegisterDetail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    'assets/images/welcome.png',
                    height: 200,
                  ),
                  const SizedBox(height: 15),

                  // Welcome Text
                  const Text(
                    'Welcome To Hi-Tech Institute',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '💯 Your Success Our Responsiblity 💯',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login Form
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          // Email Field
                          CustomTextField(
                            labelText: 'Email or Username',
                            icon: Icons.email_outlined,
                          ),
                          // Password Field
                          CustomTextField(
                            labelText: 'Password',
                            icon: Icons.lock_outline,
                            obscureText: true,
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(height: 15),

                          // Sign In Button
                          CustomButton(
                            text: 'Sign In',
                            gradientColors: [Color(0xFF0057B8), Color(0xFF009688)],
                            textColor: Colors.white,
                            onPressed: () {},
                          ),

                          const SizedBox(height: 10),

                          // Register Now with Lottie Animation
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => Center(
                                  child: Lottie.asset(
                                    'assets/animations/Animation_lottie.json',
                                    width: 150,
                                    height: 150,
                                    repeat: false,
                                    onLoaded: (composition) {
                                      Future.delayed(const Duration(seconds: 2), () {
                                        Navigator.pop(context); // Close dialog
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => VisitorEntryForm()),
                                        );
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                            child: const Text.rich(
                              TextSpan(
                                text: "Don't have an account? ",
                                children: [
                                  TextSpan(
                                    text: "Register Now",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom TextField Widget
class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final bool obscureText;

  const CustomTextField({
    required this.labelText,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.black54),
          labelText: labelText,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
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
