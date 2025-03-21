import 'package:flutter/material.dart'; // Importa a biblioteca Flutter para UI
import 'package:vertex/main_layout.dart';

// Cria a tela do contador
class ContadorPage extends StatefulWidget {
  const ContadorPage({super.key});

  @override
  State<ContadorPage> createState() => _ContadorPageState(); // Cria o estado da página
}

// Estado da tela do contador
class _ContadorPageState extends State<ContadorPage> {
  int _counter = 0; // Variável para armazenar o valor do contador

  // Função para aumentar o contador
  void _incrementCounter() {
    setState(() { // Atualiza a tela quando o valor muda
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Contador',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Você pressionou o botão este número de vezes:'),
            Text(
              '$_counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton( // Botão flutuante adicionado corretamente
        onPressed: _incrementCounter,
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
