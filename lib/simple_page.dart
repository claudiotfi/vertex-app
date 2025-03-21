import 'package:flutter/material.dart';
import 'package:vertex/main_layout.dart';

class SimplePage extends StatelessWidget {
  const SimplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Página Simples', // Define o título
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Página Simples',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Texto da página simples',
              style: TextStyle(
                fontSize: 18,
              ),
            ),

            Image.asset(  // AGORA FUNCIONA!
              'assets/logo.png',
              width: 100,
              height: 100,
            ),
          ],
        ),


      ),
    );
  }
}
