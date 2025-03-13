import 'package:flutter/material.dart';
import 'package:neon_text/neon_text.dart'; // Import the package

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NeonText Example',
      theme: ThemeData.dark(), // Set dark theme for better visibility
      home: const NeonTextDemo(),
    );
  }
}

class NeonTextDemo extends StatelessWidget {
  const NeonTextDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Neon Text Example"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NeonText(
              text: "Flutter Neon!",
              neonColor: Colors.cyanAccent,
              fontSize: 40,
              blurRadius: 20,
              strokeWidth: 2,
              letterSpacing: 2.0,
              animationType: NeonAnimationType.pulse,
              animationDuration: 3,
            ),
            const SizedBox(height: 20),
            NeonText(
              text: "Glowing Effect!",
              neonColor: Colors.pinkAccent,
              fontSize: 35,
              blurRadius: 25,
              strokeWidth: 2.5,
              animationType: NeonAnimationType.glow,
              animationDuration: 4,
            ),
            const SizedBox(height: 20),
            NeonText(
              text: "No Animation!",
              neonColor: Colors.greenAccent,
              fontSize: 30,
              blurRadius: 15,
              strokeWidth: 1.5,
              animationType: NeonAnimationType.none,
            ),
          ],
        ),
      ),
    );
  }
}
