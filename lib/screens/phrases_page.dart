import 'package:Sama_app/models/itme_model.dart';
import 'package:Sama_app/screens/PhrasesItme.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class PhrasesPage extends StatefulWidget {
  const PhrasesPage({super.key});

  @override
  State<PhrasesPage> createState() => _PhrasesPageState();
}

class _PhrasesPageState extends State<PhrasesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final TextEditingController searchController = TextEditingController();

  final List<ItmeModel> phrasesList = [
    ItmeModel(
      sound: 'sounds/phrases/are_you_coming.wav',
      enName: 'are you coming',
      jpName: '来ますか',
    ),
    ItmeModel(
      sound: 'sounds/phrases/dont_forget_to_subscribe.wav',
      enName: 'dont forget to subscribe',
      jpName: 'チャンネル登録をお忘れなく',
    ),
    ItmeModel(
      sound: 'sounds/phrases/how_are_you_feeling.wav',
      enName: 'how are you feeling',
      jpName: 'ご気分はいかがですか。',
    ),
    ItmeModel(
      sound: 'sounds/phrases/i_love_anime.wav',
      enName: 'i love anime',
      jpName: '私はアニメが大好きです',
    ),
    ItmeModel(
      sound: 'sounds/phrases/i_love_programming.wav',
      enName: 'i love programming',
      jpName: '私はプログラミングが大好きです',
    ),
    ItmeModel(
      sound: 'sounds/phrases/programming_is_easy.wav',
      enName: 'programming is easy',
      jpName: 'プログラミングは簡単です',
    ),
    ItmeModel(
      sound: 'sounds/phrases/what_is_your_name.wav',
      enName: 'what is your name',
      jpName: 'あなたの名前は何ですか',
    ),
    ItmeModel(
      sound: 'sounds/phrases/where_are_you_going.wav',
      enName: 'where are you going',
      jpName: 'どこに行くの',
    ),
    ItmeModel(
      sound: 'sounds/phrases/yes_im_coming.wav',
      enName: 'yes im coming',
      jpName: 'はい、来ます',
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

    filteredList = phrasesList;
  }

  void filterSearch(String value) {
    setState(() {
      filteredList = phrasesList
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
              'Phrases',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.lightBlue.withOpacity(0.8),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.lightBlue.withOpacity(0.8),
                  Colors.blueAccent.withOpacity(0.6),
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
                      hintText: "Search phrase...",
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
                              child: PhrasesItme(
                                phrases: filteredList[index],
                                color: Colors.lightBlue,
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
