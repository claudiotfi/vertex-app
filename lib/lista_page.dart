import 'package:flutter/material.dart'; // Importa a biblioteca Flutter para UI
import 'package:vertex/main_layout.dart';

class ListaPage extends StatelessWidget {
  const ListaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> itens = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

    return MainLayout(
      title: 'Listas', // Define o título
      child: ListView.builder( // Cria uma lista que se ajusta automaticamente
        itemCount: itens.length, // Define quantos itens a lista tem
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(itens[index]), // Exibe o nome do item na lista
            leading: const Icon(Icons.star), // Ícone ao lado do item
            onTap: () { // Ação ao tocar no item
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Você clicou em ${itens[index]}')), // Mensagem temporária
              );
            },
          );
        },
      ),
    );
  }
}
