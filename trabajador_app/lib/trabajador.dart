class Trabajador {
  final int id;
  final String nombre;
  final String especialidad;
  final String numero;
  final String descripcion;
  final String edad;

  Trabajador({
    required this.id,
    required this.nombre,
    required this.especialidad,
    required this.numero,
    required this.descripcion,
    required this.edad,
  });

  factory Trabajador.fromJson(Map<String, dynamic> json) {
    return Trabajador(
      id: json['id'],
      nombre: json['nombre'],
      especialidad: json['especialidad'],
      numero: json['numero'],
      descripcion: json['descripcion'],
      edad: json['edad'],
    );
  }
}
