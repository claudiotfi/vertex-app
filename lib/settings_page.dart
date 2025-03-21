import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vertex/main_layout.dart';

typedef Settings = Map<String, dynamic>;

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

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _notificationsEnabled = prefs.getBool('notifications') ?? false;
      _darkTheme = prefs.getBool('darkTheme') ?? false;
      _fontSize = prefs.getDouble('fontSize') ?? 14.0;
    });
  }

  Future<void> _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setBool('notifications', _notificationsEnabled);
    await prefs.setBool('darkTheme', _darkTheme);
    await prefs.setDouble('fontSize', _fontSize);
    _showMessage("Configurações salvas com sucesso!");
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 2)),
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
              onPressed: _saveSettings,
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
