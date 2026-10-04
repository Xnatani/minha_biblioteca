class Livro {
  final String id;
  final String titulo;
  final String autor;
  final String situacao;

  const Livro({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.situacao,
  });

  Livro copyWith({String? titulo, String? autor, String? situacao}) {
    return Livro(
      id: id,
      titulo: titulo ?? this.titulo,
      autor: autor ?? this.autor,
      situacao: situacao ?? this.situacao,
    );
  }
}
