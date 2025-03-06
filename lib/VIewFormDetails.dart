import 'package:flutter/material.dart';

class Viewformdetails extends StatelessWidget {
  final Map<String, dynamic> visitor;

  const Viewformdetails({super.key, required this.visitor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "Visitor Details",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Card(
              color: Colors.white,
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  width: 2,
                  color: Color(0xFF0057B8), // Border color
                ),
              ),
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.2, // Light watermark effect
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo_hiet.jpeg',
                        width: 250,
                          fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow("Name", visitor['name']),
                        _buildDetailRow("Email", visitor['email']),
                        _buildDetailRow("Phone", visitor['phone'].toString()),
                        _buildDetailRow("Alternate Phone",
                            visitor['alternate_phone'].toString()),
                        _buildDetailRow(
                            "Contact Person", visitor['contact_person']),
                        _buildDetailRow("Purpose", visitor['purpose']),
                        _buildDetailRow("Address", visitor['address']),
                        _buildDetailRow("IP Address", visitor['ipAddress']),
                        _buildDetailRow("Date", visitor['current_date']),
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

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // Ensures space between title and value
        children: [
          Text(
            "$title: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 10), // Space between title and value
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              // Aligns text to the right for better spacing
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
