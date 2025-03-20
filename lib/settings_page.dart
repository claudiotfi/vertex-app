import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configurações',
          style: TextStyle(color: Colors.white), // Cor do texto
        ),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white, // Define o ícone do menu como branco
      ),
      body: const Center(
        child: Text(
          'Página de Configurações',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}