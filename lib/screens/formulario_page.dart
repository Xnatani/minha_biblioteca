import 'package:flutter/material.dart';

import '../models/livro.dart';

class FormularioPage extends StatefulWidget {
  final Livro? livroInicial;
  final void Function(Livro) onSalvar;

  const FormularioPage({super.key, this.livroInicial, required this.onSalvar});

  @override
  State<FormularioPage> createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _tituloController;
  late final TextEditingController _autorController;
  late String _situacao;

  static const List<String> _situacoes = ['Quero ler', 'Lendo', 'Concluído'];

  bool get _editando => widget.livroInicial != null;

  @override
  void initState() {
    super.initState();
    final livro = widget.livroInicial;
    _tituloController = TextEditingController(text: livro?.titulo ?? '');
    _autorController = TextEditingController(text: livro?.autor ?? '');
    _situacao = livro?.situacao ?? _situacoes.first;
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _autorController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;

    final livro = Livro(
      id:
          widget.livroInicial?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      titulo: _tituloController.text.trim(),
      autor: _autorController.text.trim(),
      situacao: _situacao,
    );

    widget.onSalvar(livro);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_editando ? 'Editar livro' : 'Novo livro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Informe o título';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _autorController,
                decoration: const InputDecoration(
                  labelText: 'Autor',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Informe o autor';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _situacao,
                decoration: const InputDecoration(
                  labelText: 'Situação',
                  border: OutlineInputBorder(),
                ),
                items: _situacoes
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) {
                  if (v != null) setState(() => _situacao = v);
                },
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _salvar,
                icon: const Icon(Icons.save),
                label: Text(_editando ? 'Salvar alterações' : 'Adicionar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
