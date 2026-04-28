import 'package:Sama_app/screens/SplashScreen.dart';
import 'package:Sama_app/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SamaApp());
}

class SamaApp extends StatelessWidget {
  const SamaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // 🔥 أول شاشة
      initialRoute: '/',

      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(),
      },

      // 🎨 شكل التطبيق العام
      theme: ThemeData(
        primarySwatch: Colors.brown,
        useMaterial3: true,
      ),
    );
  }
}
