class NotificacionData {
  String? idnotificacion;
  String? accion;
  dynamic contenido;

  NotificacionData({
    this.idnotificacion = "",
    this.accion = "",
    this.contenido,
  });

  Map toJson() => {
    'idnotificacion'  : idnotificacion,
    'accion'          : accion,
    'contenido'       : contenido,
  };

  NotificacionData.fromServer(Map<String, dynamic> json) {
    idnotificacion = json['idnotificacion'];
    accion = json['accion'];
    contenido = json['contenido'];
  }
}