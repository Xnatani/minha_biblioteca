import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:minha_biblioteca/models/livro.dart';
import 'package:minha_biblioteca/screens/lista_page.dart';
import 'package:minha_biblioteca/widgets/livro_card.dart';
import 'package:minha_biblioteca/widgets/estado_vazio.dart';

void main() {
  testWidgets('mostra o estado vazio quando não há livros', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: ListaPage(livrosIniciais: <Livro>[])),
    );

    expect(find.byType(EstadoVazio), findsOneWidget);
    expect(find.textContaining('Nenhum livro cadastrado'), findsOneWidget);
    expect(find.byType(LivroCard), findsNothing);
  });

  testWidgets('mostra os livros quando a coleção não está vazia', (
    tester,
  ) async {
    const livros = [
      Livro(id: '1', titulo: 'O Hobbit', autor: 'Tolkien', situacao: 'Lendo'),
      Livro(id: '2', titulo: 'Duna', autor: 'Herbert', situacao: 'Lendo'),
    ];

    await tester.pumpWidget(
      const MaterialApp(home: ListaPage(livrosIniciais: livros)),
    );

    expect(find.byType(EstadoVazio), findsNothing);
    expect(find.byType(LivroCard), findsNWidgets(2));
    expect(find.text('O Hobbit'), findsOneWidget);
    expect(find.text('Duna'), findsOneWidget);
  });
}
