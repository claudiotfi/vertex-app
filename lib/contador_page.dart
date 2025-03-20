import 'package:flutter/material.dart'; // Importa a biblioteca Flutter para UI

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contador',
          style: TextStyle(color: Colors.white), // Cor do texto
        ),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white, // Define o ícone do menu como branco
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza os elementos na tela
          children: <Widget>[
            const Text('Você pressionou o botão este número de vezes:'), // Texto fixo
            Text(
              '$_counter', // Mostra o valor do contador
              style: Theme.of(context).textTheme.headlineMedium, // Define o tamanho do texto
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton( // Botão flutuante
        onPressed: _incrementCounter, // Quando pressionado, chama a função _incrementCounter
        tooltip: 'Incrementar', // Mensagem ao passar o mouse
        child: const Icon(Icons.add), // Ícone de "+"
      ),
    );
  }
}
