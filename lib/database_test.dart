import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:vertex/main_layout.dart';

void main() {
  runApp(TestDatabaseApp());
}

class TestDatabaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DatabaseTestPage(),
    );
  }
}

class DatabaseTestPage extends StatefulWidget {
  @override
  _DatabaseTestPageState createState() => _DatabaseTestPageState();
}

class _DatabaseTestPageState extends State<DatabaseTestPage> {
  Database? _database;
  String _statusMessage = "Pressione o botão para testar o banco de dados";

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    try {
      String path = join(await getDatabasesPath(), 'test.db');
      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
            '''CREATE TABLE IF NOT EXISTS test_table(
                id INTEGER PRIMARY KEY AUTOINCREMENT, 
                value TEXT
            )''',
          );
        },
      );
      setState(() {
        _statusMessage = "Banco de dados inicializado com sucesso!";
      });
    } catch (e) {
      setState(() {
        _statusMessage = "Erro ao inicializar o banco: $e";
      });
    }
  }

  Future<void> _insertTestData() async {
    if (_database == null) {
      setState(() {
        _statusMessage = "Erro: Banco de dados não inicializado!";
      });
      return;
    }

    try {
      await _database!.insert(
        'test_table',
        {'value': 'Teste SQLite'},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      setState(() {
        _statusMessage = "Dados inseridos com sucesso!";
      });
    } catch (e) {
      setState(() {
        _statusMessage = "Erro ao inserir dados: $e";
      });
    }
  }

  Future<void> _readTestData() async {
    if (_database == null) {
      setState(() {
        _statusMessage = "Erro: Banco de dados não inicializado!";
      });
      return;
    }

    try {
      List<Map<String, dynamic>> result = await _database!.query('test_table');
      if (result.isNotEmpty) {
        setState(() {
          _statusMessage = "Dados recuperados: ${result[0]['value']}";
        });
      } else {
        setState(() {
          _statusMessage = "Nenhum dado encontrado!";
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = "Erro ao ler dados: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Teste SQLite', // Define o título
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              _statusMessage,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _insertTestData,
              child: Text('Inserir Dados'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _readTestData,
              child: Text('Ler Dados'),
            ),
          ],
        ),
      ),
    );
  }
}
