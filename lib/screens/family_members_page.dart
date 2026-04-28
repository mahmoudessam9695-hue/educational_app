import 'package:Sama_app/itme.dart';
import 'package:Sama_app/models/itme_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class FamilyMembersPage extends StatefulWidget {
  const FamilyMembersPage({super.key});

  @override
  State<FamilyMembersPage> createState() => _FamilyMembersPageState();
}

class _FamilyMembersPageState extends State<FamilyMembersPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final TextEditingController searchController = TextEditingController();

  final List<ItmeModel> familyList = const [
    ItmeModel(
      enName: 'father',
      jpName: 'chichi',
      image: 'assets/images/family_members/family_father.png',
      sound: 'sounds/family_members/father.wav',
    ),
    ItmeModel(
      enName: 'mother',
      jpName: 'haha',
      image: 'assets/images/family_members/family_mother.png',
      sound: 'sounds/family_members/mother.wav',
    ),
    ItmeModel(
      enName: 'son',
      jpName: 'musuko',
      image: 'assets/images/family_members/family_son.png',
      sound: 'sounds/family_members/son.wav',
    ),
    ItmeModel(
      enName: 'daughter',
      jpName: 'musume',
      image: 'assets/images/family_members/family_daughter.png',
      sound: 'sounds/family_members/daughter.wav',
    ),
    ItmeModel(
      enName: 'grandfather',
      jpName: 'sofu',
      image: 'assets/images/family_members/family_grandfather.png',
      sound: 'sounds/family_members/grand_father.wav',
    ),
    ItmeModel(
      enName: 'grandmother',
      jpName: 'sobo',
      image: 'assets/images/family_members/family_grandmother.png',
      sound: 'sounds/family_members/grand_mother.wav',
    ),
    ItmeModel(
      enName: 'older brother',
      jpName: 'ani',
      image: 'assets/images/family_members/family_older_brother.png',
      sound: 'sounds/family_members/older_brother.wav',
    ),
    ItmeModel(
      enName: 'older sister',
      jpName: 'ane',
      image: 'assets/images/family_members/family_older_sister.png',
      sound: 'sounds/family_members/older_sister.wav',
    ),
    ItmeModel(
      enName: 'younger brother',
      jpName: 'otouto',
      image: 'assets/images/family_members/family_younger_brother.png',
      sound: 'sounds/family_members/younger_brother.wav',
    ),
    ItmeModel(
      enName: 'younger sister',
      jpName: 'imouto',
      image: 'assets/images/family_members/family_younger_sister.png',
      sound: 'sounds/family_members/younger_sister.wav',
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

    filteredList = familyList;
  }

  void filterSearch(String value) {
    setState(() {
      filteredList = familyList
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
              'Family Members',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.green.withOpacity(0.8),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.withOpacity(0.8),
                  Colors.teal.withOpacity(0.6),
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
                      hintText: "Search family member...",
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
                                color: Colors.green,
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
