import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/lista_page.dart';

void main() {
  runApp(const MinhaBibliotecaApp());
}

class MinhaBibliotecaApp extends StatelessWidget {
  const MinhaBibliotecaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Biblioteca',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const ListaPage(),
    );
  }
}
