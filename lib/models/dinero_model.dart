class DineroModel {
  final String? id;
  final String? detallesUrl;
  final String? titulo;
  final String? descripcion;
  final String? denominacion;
  final String? imagenFondoUrl;
  final String? imagenFondoUrlHD;
  final int orden;

  DineroModel({
    this.id,
    this.detallesUrl,
    this.titulo,
    this.descripcion,
    this.denominacion,
    this.imagenFondoUrl,
    this.imagenFondoUrlHD,
    this.orden = 0,
  });

  factory DineroModel.fromJson(Map<String, dynamic> json) {
    return DineroModel(
      id: json['id'],
      detallesUrl: json['detallesUrl'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      denominacion: json['denominacion'],
      imagenFondoUrl: json['imagenFondoUrl'],
      imagenFondoUrlHD: json['imagenFondoUrl'].replaceAll('/web/', '/hd/'),
      orden: json['orden'],
    );
  }
}
