import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController confirmPassCtrl = TextEditingController();

  SignUpScreen({super.key});

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
                children: [
                  Image.asset('assets/images/welcome.png', height: 150),
                  const SizedBox(height: 10),
                  const Text(
                    'Create Your Account',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          CustomTextField(controller: nameCtrl, labelText: 'Full Name', icon: Icons.person_outline),
                          CustomTextField(controller: emailCtrl, labelText: 'Email', icon: Icons.email_outlined),
                          CustomTextField(controller: phoneCtrl, labelText: 'Phone Number', icon: Icons.phone_outlined),
                          CustomTextField(controller: passCtrl, labelText: 'Password', icon: Icons.lock_outline, isPassword: true),
                          CustomTextField(controller: confirmPassCtrl, labelText: 'Confirm Password', icon: Icons.lock_outline, isPassword: true),
                          const SizedBox(height: 15),
                          CustomButton(
                            text: 'Sign Up',
                            gradientColors: [Color(0xFF0057B8), Color(0xFF009688)],
                            textColor: Colors.white,
                            onPressed: () {},
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text.rich(
                              TextSpan(
                                text: "Already have an account? ",
                                children: [
                                  TextSpan(
                                    text: "Sign In",
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
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

// Custom TextField Widget (Converted to StatefulWidget)
class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool isPassword;

  const CustomTextField({
    required this.controller,
    required this.labelText,
    required this.icon,
    this.isPassword = false,
    super.key,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : false,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon, color: Colors.black54),
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : null,
          labelText: widget.labelText,
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
    super.key,
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
