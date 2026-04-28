import 'package:Sama_app/itme.dart';
import 'package:Sama_app/models/itme_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ColorPage extends StatefulWidget {
  const ColorPage({super.key});

  @override
  State<ColorPage> createState() => _ColorPageState();
}

class _ColorPageState extends State<ColorPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final TextEditingController searchController = TextEditingController();

  final List<ItmeModel> colorsList = const [
    ItmeModel(
      enName: 'black',
      jpName: 'kuro',
      image: 'assets/images/colors/color_black.png',
      sound: 'sounds/colors/black.wav',
    ),
    ItmeModel(
      enName: 'brown',
      jpName: 'chairo',
      image: 'assets/images/colors/color_brown.png',
      sound: 'sounds/colors/brown.wav',
    ),
    ItmeModel(
      enName: 'dusty yellow',
      jpName: 'kusunda kiiro',
      image: 'assets/images/colors/color_dusty_yellow.png',
      sound: 'sounds/colors/dusty_yellow.wav',
    ),
    ItmeModel(
      enName: 'gray',
      jpName: 'haiiro',
      image: 'assets/images/colors/color_gray.png',
      sound: 'sounds/colors/gray.wav',
    ),
    ItmeModel(
      enName: 'green',
      jpName: 'midori',
      image: 'assets/images/colors/color_green.png',
      sound: 'sounds/colors/green.wav',
    ),
    ItmeModel(
      enName: 'red',
      jpName: 'aka',
      image: 'assets/images/colors/color_red.png',
      sound: 'sounds/colors/red.wav',
    ),
    ItmeModel(
      enName: 'white',
      jpName: 'shiro',
      image: 'assets/images/colors/color_white.png',
      sound: 'sounds/colors/white.wav',
    ),
    ItmeModel(
      enName: 'yellow',
      jpName: 'kiiro',
      image: 'assets/images/colors/yellow.png',
      sound: 'sounds/colors/yellow.wav',
    ),
  ];

  List<ItmeModel> filteredList = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);

    filteredList = colorsList;
  }

  void filterSearch(String value) {
    setState(() {
      filteredList = colorsList
          .where(
            (item) => item.enName.toLowerCase().contains(value.toLowerCase()),
          )
          .toList();
    });
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              'Colors',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.deepPurple.withOpacity(0.8),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.withOpacity(0.8),
                  Colors.purpleAccent.withOpacity(0.6),
                  Colors.blue.withOpacity(0.5),
                ],
                stops: [0.0, 0.5 + sin(_controller.value * pi) * 0.2, 1.0],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),

                // 🔍 SEARCH
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: searchController,
                    onChanged: filterSearch,
                    decoration: InputDecoration(
                      hintText: "Search color...",
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
                  child: filteredList.isEmpty
                      ? const Center(
                          child: Text(
                            "No results 😅",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            return TweenAnimationBuilder(
                              duration: Duration(
                                milliseconds: 300 + index * 100,
                              ),
                              tween: Tween<double>(begin: 0, end: 1),
                              builder: (context, value, child) {
                                return Opacity(
                                  opacity: value,
                                  child: Transform.translate(
                                    offset: Offset(0, (1 - value) * 30),
                                    child: child,
                                  ),
                                );
                              },
                              child: Itme(
                                number: filteredList[index],
                                color: Colors.deepPurple,
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
    );
  }
}
