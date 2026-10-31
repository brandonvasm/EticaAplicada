class Tramite {
  final int id;
  final String titulo;
  final String institucion;
  final List<String> requisitos;

  Tramite({
    required this.id,
    required this.titulo,
    required this.institucion,
    required this.requisitos,
  });

  factory Tramite.fromJson(Map<String, dynamic> json) {
    return Tramite(
      id: json['id'],
      titulo: json['titulo'],
      institucion: json['institucion'],
      requisitos: List<String>.from(json['requisitos']),
    );
  }
}