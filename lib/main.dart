import 'package:flutter/material.dart';
import 'package:vertex/simple_page.dart';
import 'settings_page.dart';
import 'lista_page.dart';
import 'contador_page.dart';
import 'database_test.dart';
import 'tasks_page.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:vertex/main_layout.dart';

void main() {
  // Para Linux e Windows, inicializar corretamente o SQLite
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Dashboard', // Define o título
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Mantém a altura apenas necessária
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente
          children: [
            Text(
              'Bem Vindo!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20), // Adiciona um espaço entre o texto e a imagem
            Image.asset(
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