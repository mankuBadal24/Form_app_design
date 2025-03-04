import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_check/Api/ApiURL.dart';
import 'package:photo_check/VisitorList.dart';

class Editform extends StatefulWidget {
  final Map<String, dynamic> visitor;

  const Editform({super.key, required this.visitor});

  @override
  State<Editform> createState() => _EditformState();
}

class _EditformState extends State<Editform> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController alternatePhoneController;
  late TextEditingController contactPersonController;
  late TextEditingController purposeController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.visitor['name']);
    emailController = TextEditingController(text: widget.visitor['email']);
    phoneController = TextEditingController(text: widget.visitor['phone'].toString());
    alternatePhoneController = TextEditingController(text: widget.visitor['alternate_phone'].toString());
    contactPersonController = TextEditingController(text: widget.visitor['contact_person']);
    purposeController = TextEditingController(text: widget.visitor['purpose']);
    addressController = TextEditingController(text: widget.visitor['address']);
  }

  Future<void> updateVisitor() async {
    if (_formKey.currentState!.validate()) {
      var url = Uri.parse("${ApiURL.getURL()}editVisitor.php");

      var response = await http.post(
        url,
        body: {
          "id": widget.visitor['id'].toString(),
          "name": nameController.text,
          "email": emailController.text,
          "phone": phoneController.text,
          "alternate_phone": alternatePhoneController.text,
          "contact_person": contactPersonController.text,
          "purpose": purposeController.text,
          "address": addressController.text,
        },
      );

      if (response.statusCode == 200) {
        _showMessage("Visitor Details Edit Successfully");
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const VisitorsListScreen()));
      } else {
          _showMessage("Failed to update visitor");
      }
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
                Image.asset('assets/images/tick.png', height: 80), // Custom warning image
                const SizedBox(height: 10),
                const Text(
                  "Done",
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
                        Navigator.of(context).pop(); // Close the dialog
                        Navigator.of(context).pop(); // Pop the Edit Screen
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => VisitorsListScreen()),
                        );
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
        automaticallyImplyLeading: false,
        title: const Text(
          "Edit Visitor",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
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
          child: SingleChildScrollView( // Allows scrolling when keyboard is open
            child: Card(
              elevation: 4,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  width: 2,
                  color: Color(0xFF0057B8),
                ),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.94,
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTextField("Name", nameController),
                      _buildTextField("Email", emailController),
                      _buildPhoneField("Phone", phoneController),
                      _buildPhoneField("Alternate Phone", alternatePhoneController),
                      _buildTextField("Contact Person", contactPersonController),
                      _buildTextField("Purpose", purposeController),
                      _buildTextField("Address", addressController),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF0057B8), Color(0xFF009688)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ElevatedButton(
                          onPressed: updateVisitor,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            "Save",
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
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white.withOpacity(0.9),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter $label";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPhoneField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white.withOpacity(0.9),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter $label";
          } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
            return "Enter a valid 10-digit number";
          }
          return null;
        },
      ),
    );
  }
}
