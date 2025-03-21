import 'package:flutter/material.dart';
import 'package:vertex/simple_page.dart';
import 'settings_page.dart';
import 'lista_page.dart';
import 'contador_page.dart';
import 'database_test.dart';
import 'tasks_page.dart';
import 'main.dart';

import 'dart:typed_data';
import 'package:flutter/services.dart';

class MainLayout extends StatefulWidget {
  final String title;
  final Widget child;
  final Widget? floatingActionButton;

  const MainLayout({
    super.key,
    required this.title,
    required this.child,
    this.floatingActionButton,
  });

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: widget.floatingActionButton,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blueAccent),
              child: Align(
                alignment: Alignment.centerLeft, // Alinha todo o conteúdo à esquerda
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Mantém os elementos alinhados à esquerda
                  mainAxisSize: MainAxisSize.min, // Impede que a coluna ocupe todo o espaço vertical
                  children: [
                    const Text(
                      'Menu',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    const SizedBox(height: 8), // Espaço entre o texto e a imagem
                    SizedBox(
                      width: 90,
                      height: 90,
                      child: Image.asset('assets/logo-inverse.png', fit: BoxFit.contain),
                    ),
                  ],
                ),
              ),
            ),

            _buildMenuItem(context, Icons.dashboard, 'Dashboard', const HomePage()),
            _buildMenuItem(context, Icons.pages, 'Página Simples', const SimplePage()),
            _buildMenuItem(context, Icons.list, 'Lista', const ListaPage()),
            _buildMenuItem(context, Icons.plus_one, 'Contador', const ContadorPage()),
            _buildMenuItem(context, Icons.settings, 'Configurações', SettingsPage()),
            _buildMenuItem(context, Icons.task, 'Tarefas', TasksPage()),
            _buildMenuItem(context, Icons.checklist_rtl, 'DB Teste', DatabaseTestPage()),
          ],
        ),
      ),
      body: widget.child,
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String text, Widget page) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}

