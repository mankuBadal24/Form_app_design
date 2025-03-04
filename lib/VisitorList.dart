import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_check/Api/ApiURL.dart';
import 'package:photo_check/EditForm.dart';
import 'package:photo_check/VIewFormDetails.dart';

class VisitorsListScreen extends StatefulWidget {
  const VisitorsListScreen({super.key});

  @override
  _VisitorsListScreenState createState() => _VisitorsListScreenState();
}

class _VisitorsListScreenState extends State<VisitorsListScreen> with SingleTickerProviderStateMixin {
  List visitors = [];
  bool isLoading = true;
  String URL = ApiURL.getURL();
  late TabController _tabController;
  int itemsPerPage = 8;

  @override
  void initState() {
    super.initState();
    fetchVisitors();
  }

  Future<void> fetchVisitors() async {
    try {
      final response = await http.get(Uri.parse("${URL}visitorList.php"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status']) {
          setState(() {
            visitors = data['data'];
            int pageCount = (visitors.length / itemsPerPage).ceil();
            _tabController = TabController(length: pageCount, vsync: this);
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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
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
        bottom: isLoading || visitors.isEmpty
            ? null
            : TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: List.generate(
            (_tabController.length),
                (index) => Tab(text: "Page ${index + 1}"),
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
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : visitors.isEmpty
            ? const Center(child: Text("No visitors found.", style: TextStyle(color: Colors.white)))
            : TabBarView(
          controller: _tabController,
          children: List.generate(
            _tabController.length,
                (index) {
              int startIndex = index * itemsPerPage;
              int endIndex = startIndex + itemsPerPage;
              List pageVisitors = visitors.sublist(startIndex, endIndex > visitors.length ? visitors.length : endIndex);

              return Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.88,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(
                        width: 2,
                        color: Color(0xFF009688),
                      ),
                    ),
                    elevation: 8,
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
                          padding: const EdgeInsets.all(15),
                          child: ListView.builder(
                            itemCount: pageVisitors.length,
                            itemBuilder: (context, index) {
                              final visitor = pageVisitors[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(
                                    width: 2,
                                    color: Color(0xFF0057B8),
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
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xFF0057B8), width: 2),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(Icons.edit, color: Color(0xFF009688)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Editform(visitor: visitor),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xFF009688), width: 2),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(Icons.remove_red_eye, color: Color(0xFF0057B8)),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Viewformdetails(visitor: visitor),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
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
              );
            },
          ),
        ),
      ),
    );
  }
}
