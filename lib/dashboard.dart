import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_check/RegisterDetail.dart';
import 'package:photo_check/VisitorList.dart';
import 'package:photo_check/shared%20Prefrences/Sharedprefrences.dart';

import 'LoginScreen.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Visitor Query Page",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0057B8), Color(0xFF009688)],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0057B8), Color(0xFF009688)],
                ),
              ),
              child: const Column(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50, color: Color(0xFF0057B8)),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Amar Nath",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const Text(
                    "amar@gmail.com",
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),

            // Drawer Items with White Background
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.exit_to_app, color: Colors.red),
                    title: const Text("Log Out"),
                    onTap: () {
                      UserSharedPreferences pref = UserSharedPreferences();
                      pref.clearUserData();
                      // Navigate to LoginScreen and remove all previous routes
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                            (route) => false, // Removes all previous routes
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0057B8), Color(0xFF009688)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.89,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: const BorderSide(
                  width: 2.0,
                  style: BorderStyle.solid,
                  color: Color(0xFF0057B8),
                ),
              ),
              elevation: 8,
              child: Stack(
                children: [
                  // Watermark Logo
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.15,
                      child: Center(
                        child: Image.asset(
                          'assets/images/logo_hiet.jpeg',
                          width: 250,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        buildDashboardCard(
                          context,
                          "Visitor Entry Form",
                          "assets/images/edit_form.png",
                              () {
                            showLoadingAnimation(context, const VisitorEntryForm());
                          },
                        ),
                        buildDashboardCard(
                          context,
                          "View Visitors",
                          "assets/images/visitor_entry.png",
                              () {
                            showLoadingAnimation(context, const VisitorsListScreen());
                          },
                        ),
                      ],
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



  Widget buildDashboardCard(
      BuildContext context, String title, String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            width: 2.0,
            style: BorderStyle.solid,
            color: Color(0xFF0057B8),
          ),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show animation before navigation
  void showLoadingAnimation(BuildContext context, Widget nextPage) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context); // Close animation
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => nextPage),
          );
        });

        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: Lottie.asset(
              'assets/animations/Animation_lottie.json',
              width: 150,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}
