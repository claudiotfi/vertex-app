import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseTestPage extends StatefulWidget {
  const DatabaseTestPage({super.key});

  @override
  _DatabaseTestPageState createState() => _DatabaseTestPageState();
}

class _DatabaseTestPageState extends State<DatabaseTestPage> {
  String _statusMessage = "Pressione o botão para testar o banco de dados";

  Future<void> _testDatabase() async {
    try {
      // Abre o banco de dados usando o sqflite padrão
      String path = join(await getDatabasesPath(), 'test.db');
      var database = await openDatabase(
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

      // Insere um dado de teste
      await database.insert(
        'test_table',
        {'value': 'Teste SQLite'},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Lê o dado inserido
      List<Map<String, dynamic>> result = await database.query('test_table');
      await database.close();

      if (result.isNotEmpty) {
        setState(() {
          _statusMessage = "Sucesso! Dado inserido e lido: ${result[0]['value']}";
        });
      } else {
        setState(() {
          _statusMessage = "Erro: Nenhum dado encontrado após inserção.";
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = "Erro ao testar o banco de dados: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _statusMessage,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _testDatabase,
              child: const Text('Testar Banco de Dados'),
            ),
          ],
        ),
      ),
    );
  }
}