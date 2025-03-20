import 'package:flutter/material.dart';
import 'package:vertex/page_one_page.dart';
import 'settings_page.dart';
import 'lista_page.dart';
import 'contador_page.dart';

void main() {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white), // Cor do texto
        ),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white, // Define o ícone do menu como branco
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.pages),
              title: const Text('Página 1'),
              onTap: () {
                Navigator.pop(context); // Fecha o Drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PageOnePage()),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Lista'),
              onTap: () {
                Navigator.pop(context); // Fecha o Drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListaPage()),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.plus_one),
              title: const Text('Contador'),
              onTap: () {
                Navigator.pop(context); // Fecha o Drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContadorPage()),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pop(context); // Fecha o Drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),

          ],
        ),
      ),
      body: const Center(
        child: Text(
          'Bem Vindo!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}