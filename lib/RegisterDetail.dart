import 'package:flutter/material.dart';
import 'package:photo_check/Api/ApiURL.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'dart:convert';

import 'package:photo_check/VisitorList.dart';

class VisitorEntryApp extends StatelessWidget {
  const VisitorEntryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0057B8),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF0057B8),
          secondary: Color(0xFFF5F8F8),
        ),
      ),
      home: const VisitorEntryForm(),
    );
  }
}

class VisitorEntryForm extends StatefulWidget {
  const VisitorEntryForm({super.key});

  @override
  State<VisitorEntryForm> createState() => _VisitorEntryFormState();
}

class _VisitorEntryFormState extends State<VisitorEntryForm> {
  // final _formKey = GlobalKey<FormState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController contactCtrl = TextEditingController();
  final TextEditingController altercontactCtrl = TextEditingController();
  final TextEditingController conPersonCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  String? selectedPurpose;
  String URL = ApiURL.getURL();
  bool isSubmitting = false; // To track if animation is running

  // bool _validateFields(){
  //   return _formKey.currentState?.validate() ?? false;
  // }

  bool _validateFields() {
    if (nameCtrl.text.isEmpty ||
        emailCtrl.text.isEmpty ||
        contactCtrl.text.isEmpty ||
        altercontactCtrl.text.isEmpty ||
        conPersonCtrl.text.isEmpty ||
        addressCtrl.text.isEmpty ||
        selectedPurpose == null) {
      _showMessage("All fields are mandatory. Please fill in all details.");
      return false;
    }
    if (contactCtrl.text.length != 10 || altercontactCtrl.text.length !=10) {
      _showMessage("Contact number must be exactly 10 digits.");
      return false;
    }
    return true;
  }
  void animater() {
    if (_validateFields()) {
      setState(() {
        isSubmitting = true; // Show animation
      });

      // Wait for animation to complete
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isSubmitting = false;
        });

          saveVisitor();
        // Navigate to List Page after animation
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => ListPage()),
        // );
      });
    }
  }

  void _clearFields(){
    nameCtrl.clear();
    emailCtrl.clear();
    contactCtrl.clear();
    altercontactCtrl.clear();
    conPersonCtrl.clear();
    addressCtrl.clear();
}

  Future<void> saveVisitor() async {

    if (_validateFields()== false) {
      return;
    }
    else {
      String uri = '${URL}addVisitor.php';
      try {
        final response = await http.post(
          Uri.parse(uri),
          body: {
            "name": nameCtrl.text,
            "email": emailCtrl.text,
            "phone": contactCtrl.text,
            "alternate_phone": altercontactCtrl.text,
            "contact_person": conPersonCtrl.text,
            "purpose": selectedPurpose ?? '',
            "address": addressCtrl.text,
          },
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data["status"]) {
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> VisitorsListScreen()));
          } else {
            _showMessage("Failed To Add Visitor");
          }
        } else {
          _showMessage("Server Error");
        }
      } catch (e) {
        _showMessage("Error : $e");
      }
      _clearFields();
    }
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/warning.png', height: 80), // Custom warning image
                const SizedBox(height: 10),
                const Text(
                  "Alert",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Visitor Entry Form",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0057B8), Color(0xFF009688)],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0057B8), Color(0xFF009688)],
                      ),
                    ),
                    padding: EdgeInsets.all(1), // To make the border visible
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 6,
                      child: Stack(
                        children: [
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
                            padding: const EdgeInsets.all(25),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildLabeledTextField("Visitor's Name", "Visitor name", nameCtrl),
                                buildLabeledTextField("Email", "Email", emailCtrl, keyboardType: TextInputType.emailAddress),
                                buildLabeledTextField("Contact No", "Contact number", contactCtrl, keyboardType: TextInputType.phone),
                                buildLabeledTextField("Alternate Contact No", "Alternate contact", altercontactCtrl, keyboardType: TextInputType.phone),
                                buildLabeledTextField("Contact Person (To whom to meet)", "Contact person", conPersonCtrl),

                                const Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 5),
                                  child: Text(
                                    "Purpose",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    RadioListTile(
                                      title: const Text("Admission",style: TextStyle(fontWeight: FontWeight.bold),),
                                      value: "Admission",
                                      groupValue: selectedPurpose,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedPurpose = value.toString();
                                        });
                                      },
                                      activeColor: const Color(0xFF009688),
                                    ),
                                    RadioListTile(
                                      title: const Text("Other", style: TextStyle(fontWeight: FontWeight.bold),),
                                      value: "Other",
                                      groupValue: selectedPurpose,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedPurpose = value.toString();
                                        });
                                      },
                                      activeColor: const Color(0xFF009688),
                                    ),
                                  ],
                                ),
                                buildLabeledTextField("Visitor Address", "Visitor address", addressCtrl),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFF0057B8), Color(0xFF009688)],
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      onPressed: isSubmitting ? null : animater,
                                      child: const Text(
                                        "Submit",
                                        style: TextStyle(fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                  ),
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
            ),
          ),
          if (isSubmitting)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Lottie.asset(
                  'assets/animations/Animation_lottie.json',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildLabeledTextField(String label, String hint, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF0057B8)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    contactCtrl.dispose();
    altercontactCtrl.dispose();
    conPersonCtrl.dispose();
    addressCtrl.dispose();
    super.dispose();
  }
}
