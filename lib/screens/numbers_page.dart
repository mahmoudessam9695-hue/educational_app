import 'package:Sama_app/itme.dart';
import 'package:Sama_app/models/itme_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class NumbersPage extends StatefulWidget {
  const NumbersPage({super.key});

  @override
  State<NumbersPage> createState() => _NumbersPageState();
}

class _NumbersPageState extends State<NumbersPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final TextEditingController searchController = TextEditingController();

  final List<ItmeModel> numbersList = const [
    ItmeModel(
      enName: 'one',
      jpName: 'ichi',
      image: 'assets/images/numbers/number_one.png',
      sound: 'sounds/numbers/number_one_sound.mp3',
    ),
    ItmeModel(
      enName: 'two',
      jpName: 'ni',
      image: 'assets/images/numbers/number_two.png',
      sound: 'sounds/numbers/number_two_sound.mp3',
    ),
    ItmeModel(
      enName: 'three',
      jpName: 'san',
      image: 'assets/images/numbers/number_three.png',
      sound: 'sounds/numbers/number_three_sound.mp3',
    ),
    ItmeModel(
      enName: 'four',
      jpName: 'shi',
      image: 'assets/images/numbers/number_four.png',
      sound: 'sounds/numbers/number_four_sound.mp3',
    ),
    ItmeModel(
      enName: 'five',
      jpName: 'go',
      image: 'assets/images/numbers/number_five.png',
      sound: 'sounds/numbers/number_five_sound.mp3',
    ),
    ItmeModel(
      enName: 'six',
      jpName: 'roku',
      image: 'assets/images/numbers/number_six.png',
      sound: 'sounds/numbers/number_six_sound.mp3',
    ),
    ItmeModel(
      enName: 'seven',
      jpName: 'shichi',
      image: 'assets/images/numbers/number_seven.png',
      sound: 'sounds/numbers/number_seven_sound.mp3',
    ),
    ItmeModel(
      enName: 'eight',
      jpName: 'hachi',
      image: 'assets/images/numbers/number_eight.png',
      sound: 'sounds/numbers/number_eight_sound.mp3',
    ),
    ItmeModel(
      enName: 'nine',
      jpName: 'kyuu',
      image: 'assets/images/numbers/number_nine.png',
      sound: 'sounds/numbers/number_nine_sound.mp3',
    ),
    ItmeModel(
      enName: 'ten',
      jpName: 'juu',
      image: 'assets/images/numbers/number_ten.png',
      sound: 'sounds/numbers/number_ten_sound.mp3',
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

    filteredList = numbersList;
  }

  void filterSearch(String value) {
    setState(() {
      filteredList = numbersList
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
              'Numbers',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.orange.withOpacity(0.8),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.orange.withOpacity(0.8),
                  Colors.deepOrange.withOpacity(0.6),
                  Colors.deepPurple.withOpacity(0.5),
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
                      hintText: "Search number...",
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
                                color: Colors.orange,
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
