import 'package:flutter/material.dart';

import '../models/livro.dart';

class LivroCard extends StatelessWidget {
  final Livro livro;
  final VoidCallback onTap;

  const LivroCard({super.key, required this.livro, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.book),
        title: Text(livro.titulo),
        subtitle: Text('${livro.autor} • ${livro.situacao}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
