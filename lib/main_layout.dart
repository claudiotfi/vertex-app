import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:vertex/simple_page.dart';
import 'package:vertex/settings_page.dart';
import 'package:vertex/lista_page.dart';
import 'package:vertex/contador_page.dart';
import 'package:vertex/database_test.dart';
import 'package:vertex/tasks_page.dart';
import 'package:vertex/main.dart'; // Importa HomeContent

class MainLayout extends StatefulWidget {
  final String title;
  final Widget child;
  final bool isHomePage;

  const MainLayout({
    super.key,
    required this.title,
    required this.child,
    this.isHomePage = false,
  });

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  DateTime? _lastPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        debugPrint('Is HomePage: ${widget.isHomePage}, child type: ${widget.child.runtimeType}');

        if (!widget.isHomePage) {
          debugPrint('Navigating to HomePage');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainLayout(
                title: 'Dashboard',
                child: const HomeContent(),
                isHomePage: true,
              ),
            ),
                (Route<dynamic> route) => false,
          );
          return false;
        }

        final now = DateTime.now();
        const exitDelay = Duration(seconds: 2);

        if (_lastPressed == null || now.difference(_lastPressed!) > exitDelay) {
          _lastPressed = now;
          debugPrint('Showing SnackBar');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Pressione novamente para sair"),
              duration: exitDelay,
            ),
          );
          return false;
        }

        debugPrint('Exiting app');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.blueAccent),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Menu',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: Image.asset('assets/logo-inverse.png', fit: BoxFit.contain),
                      ),
                    ],
                  ),
                ),
              ),
              _buildMenuItem(context, Icons.dashboard, 'Dashboard', const HomeContent()),
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
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String text, Widget page) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () {
        Navigator.pop(context); // Fecha o drawer
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainLayout(
              title: text,
              child: page,
            ),
          ),
        );
      },
    );
  }
}