import 'package:flutter/material.dart';

class PageOnePage extends StatelessWidget {
  const PageOnePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Página 1',
          style: TextStyle(color: Colors.white), // Cor do texto
        ),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white, // Define o ícone do menu como branco
      ),
      body: const Center(
        child: Text(
          'Página 1',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}