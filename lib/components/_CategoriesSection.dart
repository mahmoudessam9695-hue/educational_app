import 'package:flutter/material.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection();

  @override
  Widget build(BuildContext context) {
    final items = [
      "Numbers",
      "Family",
      "Colors",
      "Phrases",
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (context, i) {
        return TweenAnimationBuilder(
          duration: Duration(milliseconds: 300 + (i * 100)),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Opacity(opacity: value, child: child),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                items[i],
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        );
      },
    );
  }
}