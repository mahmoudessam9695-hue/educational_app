import 'package:Sama_app/screens/Color_page.dart';
import 'package:Sama_app/screens/family_members_page.dart';
import 'package:Sama_app/screens/numbers_page.dart';
import 'package:Sama_app/screens/phrases_page.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> categories = [
    {"title": "Numbers", "page": const NumbersPage()},
    {"title": "Family members", "page": const FamilyMembersPage()},
    {"title": "Colors", "page": const ColorPage()},
    {"title": "Phrases", "page": PhrasesPage()},
  ];

  List<Map<String, dynamic>> filtered = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);

    filtered = categories;
  }

  void filterSearch(String value) {
    setState(() {
      filtered = categories
          .where(
            (item) => item["title"].toLowerCase().contains(value.toLowerCase()),
          )
          .toList();
    });
  }

  void navigateTo(Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, animation, __) => page,
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.brown.withOpacity(0.8),
                  Colors.orange.withOpacity(0.6),
                  Colors.deepPurple.withOpacity(0.5),
                ],
                stops: [0.0, 0.5 + sin(_controller.value * pi) * 0.2, 1.0],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 15),

                  const Text(
                    "Sama App",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // 🔍 SEARCH BAR
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: searchController,
                      onChanged: filterSearch,
                      decoration: InputDecoration(
                        hintText: "Search category...",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 📱 LIST
                  Expanded(
                    child: filtered.isEmpty
                        ? const Center(
                            child: Text(
                              "No results found 😅",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(12),
                            itemCount: filtered.length,
                            itemBuilder: (context, index) {
                              final item = filtered[index];

                              return GestureDetector(
                                onTap: () {
                                  navigateTo(item["page"]);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Text(
                                    item["title"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
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
    );
  }
}
