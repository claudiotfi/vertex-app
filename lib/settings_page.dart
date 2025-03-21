import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as p;
import 'package:vertex/main_layout.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool _notificationsEnabled = false;
  bool _darkTheme = false;
  double _fontSize = 14.0;

  Database? _database;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    try {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;

      _database = await openDatabase(
        p.join(await getDatabasesPath(), 'settings.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE settings(id INTEGER PRIMARY KEY, key TEXT UNIQUE, value TEXT)',
          );
        },
        version: 1,
      );
      //_showMessage("Banco de dados inicializado com sucesso!", Colors.green);
      _loadSettings();
    } catch (e) {
      _showMessage("Erro ao inicializar o banco: $e", Colors.red);
    }
  }

  Future<void> _loadSettings() async {
    if (_database == null) return;
    final List<Map<String, dynamic>> maps = await _database!.query('settings');

    for (var setting in maps) {
      switch (setting['key']) {
        case 'name':
          _nameController.text = setting['value'];
          break;
        case 'email':
          _emailController.text = setting['value'];
          break;
        case 'notifications':
          _notificationsEnabled = setting['value'] == 'true';
          break;
        case 'darkTheme':
          _darkTheme = setting['value'] == 'true';
          break;
        case 'fontSize':
          _fontSize = double.tryParse(setting['value']) ?? 14.0;
          break;
      }
    }
    setState(() {});
  }

  Future<void> _saveSettings(String key, String value) async {
    try {
      if (_database == null) {
        _showMessage("Banco de dados não está pronto!", Colors.red);
        return;
      }

      await _database!.insert(
        'settings',
        {'key': key, 'value': value},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      _showMessage("Configuração salva com sucesso!", Colors.green);
    } catch (e) {
      _showMessage("Erro ao salvar configuração: $e", Colors.red);
    }
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Configurações',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SwitchListTile(
              title: Text("Ativar Notificações"),
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            SwitchListTile(
              title: Text("Tema Escuro"),
              value: _darkTheme,
              onChanged: (value) {
                setState(() {
                  _darkTheme = value;
                });
              },
            ),
            ListTile(
              title: Text("Tamanho da Fonte"),
              subtitle: Slider(
                min: 10,
                max: 24,
                value: _fontSize,
                onChanged: (value) {
                  setState(() {
                    _fontSize = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveSettings("name", _nameController.text);
                _saveSettings("email", _emailController.text);
                _saveSettings("notifications", _notificationsEnabled.toString());
                _saveSettings("darkTheme", _darkTheme.toString());
                _saveSettings("fontSize", _fontSize.toString());
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}