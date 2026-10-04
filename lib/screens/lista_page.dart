import 'package:flutter/material.dart';

import '../models/livro.dart';
import '../widgets/livro_card.dart';
import '../widgets/estado_vazio.dart';
import 'detalhe_page.dart';
import 'formulario_page.dart';

class ListaPage extends StatefulWidget {
  final List<Livro>? livrosIniciais;

  const ListaPage({super.key, this.livrosIniciais});

  @override
  State<ListaPage> createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  late final List<Livro> _livros;

  @override
  void initState() {
    super.initState();
    _livros = List.of(
      widget.livrosIniciais ??
          const [
            Livro(
              id: '1',
              titulo: 'O Hobbit',
              autor: 'J. R. R. Tolkien',
              situacao: 'Concluído',
            ),
            Livro(
              id: '2',
              titulo: 'Duna',
              autor: 'Frank Herbert',
              situacao: 'Lendo',
            ),
          ],
    );
  }

  void _adicionar(Livro livro) {
    setState(() => _livros.add(livro));
  }

  void _substituir(Livro livro) {
    setState(() {
      final index = _livros.indexWhere((l) => l.id == livro.id);
      if (index != -1) {
        _livros[index] = livro;
      }
    });
  }

  Future<void> _abrirFormulario({Livro? livro}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FormularioPage(
          livroInicial: livro,
          onSalvar: livro == null ? _adicionar : _substituir,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minha Biblioteca')),
      body: _livros.isEmpty
          ? const EstadoVazio(
              mensagem:
                  'Nenhum livro cadastrado ainda.\nToque em + para adicionar.',
            )
          : ListView.builder(
              itemCount: _livros.length,
              itemBuilder: (context, index) {
                final livro = _livros[index];
                return LivroCard(
                  livro: livro,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetalhePage(
                          livro: livro,
                          onSubstituir: _substituir,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirFormulario(),
        tooltip: 'Adicionar livro',
        child: const Icon(Icons.add),
      ),
    );
  }
}
