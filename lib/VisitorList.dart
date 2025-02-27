import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

class VisitorsListScreen extends StatefulWidget {
  const VisitorsListScreen({super.key});

  @override
  _VisitorsListScreenState createState() => _VisitorsListScreenState();
}

class _VisitorsListScreenState extends State<VisitorsListScreen> {
  List visitors = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    HttpOverrides.global = MyHttpOverrides(); // Bypass SSL
    fetchVisitors();
  }

  Future<void> fetchVisitors() async {
    try {
      final response = await http.get(Uri.parse("https://hietccsu.org/Api/visitorList.php"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status']) {
          setState(() {
            visitors = data['data'];
            isLoading = false;
          });
        }
      }
    } catch (e) {
      print("Error fetching visitors: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back arrow
        title: const Text("Visitors List"),
        centerTitle: true,
        backgroundColor: const Color(0xFF0057B8),
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0057B8), Color(0xFF009688)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
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
            height: MediaQuery.of(context).size.height * 0.88,
            width: MediaQuery.of(context).size.width * 0.95,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(
                  width: 2,
                  color: Color(0xFF009688), // Border color
                ),
              ),
              elevation: 8,
              child: Stack(
                children: [
                  // Watermark Image
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.18,
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
                    padding: const EdgeInsets.all(15),
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                      itemCount: visitors.length,
                      itemBuilder: (context, index) {
                        final visitor = visitors[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              width: 2,
                              color: Color(0xFF0057B8), // Border color for tile
                            ),
                          ),
                          color: Colors.white,
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(

                            leading: const Icon(Icons.person, color: Colors.indigo),
                            title: Text(visitor['name'],
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Email: ${visitor['email']}"),
                                Text("Phone: ${visitor['phone']}"),
                                Text("Date: ${visitor['current_date']}"),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit, color: Color(0xFF009688)),
                              onPressed: () {
                                // Handle edit action here

                              },
                            ),
                          ),
                        );
                      },
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
