import 'package:flutter/material.dart';

class VisitorEntryApp extends StatelessWidget {
  const VisitorEntryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0057B8), // Royal Blue
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF0057B8),
          secondary: const Color(0xFFF5F8F8), // Teal
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
  String? selectedPurpose; // Store selected purpose

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0057B8),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/logo_hiet.jpeg',
                        height: 80,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        "Visitor Entry Form",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0057B8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    buildLabeledTextField("Visitor's Name", "Visitor name"),
                    buildLabeledTextField("Contact No", "Contact number", keyboardType: TextInputType.phone),
                    buildLabeledTextField("Alternate Contact No", "Contact number", keyboardType: TextInputType.phone),
                    buildLabeledTextField("Contact Person (To whom to meet)", "Contact person name"),
                    buildLabeledTextField("Email", "Email", keyboardType: TextInputType.emailAddress),

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
                          title: const Text("Admission"),
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
                          title: const Text("Other"),
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

                    buildLabeledTextField("Visitor Address", "Visitor address"),

                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF388E3C),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Submit",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLabeledTextField(String label, String hint, {TextInputType keyboardType = TextInputType.text}) {
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
          TextField(
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
}