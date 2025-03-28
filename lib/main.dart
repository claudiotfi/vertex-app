import 'package:flutter/material.dart';
import 'package:vertex/simple_page.dart';
import 'package:vertex/settings_page.dart';
import 'package:vertex/lista_page.dart';
import 'package:vertex/contador_page.dart';
import 'package:vertex/database_test.dart';
import 'package:vertex/tasks_page.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:vertex/main_layout.dart';
import 'dart:io' show Platform;

void main() {
  // Configura o sqflite_common_ffi apenas para plataformas desktop
  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainLayout(
        title: 'Dashboard',
        child: const HomeContent(),
        isHomePage: true,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Bem Vindo!',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Image.asset(
            'assets/logo.png',
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }
}