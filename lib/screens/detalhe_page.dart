import 'package:flutter/material.dart';

import '../models/livro.dart';
import 'formulario_page.dart';

class DetalhePage extends StatelessWidget {
  final Livro livro;
  final void Function(Livro) onSubstituir;

  const DetalhePage({
    super.key,
    required this.livro,
    required this.onSubstituir,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(livro.titulo),
        actions: [
          IconButton(
            tooltip: 'Editar livro',
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FormularioPage(
                    livroInicial: livro,
                    onSalvar: (atualizado) {
                      onSubstituir(atualizado);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Título: ${livro.titulo}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Text(
              'Autor: ${livro.autor}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            Text(
              'Situação: ${livro.situacao}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
