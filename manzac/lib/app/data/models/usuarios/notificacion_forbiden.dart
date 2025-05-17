class NotificacionForbiden {
  String? titulo;
  String? cuerpo;
  String? idSistema;

  NotificacionForbiden({
    this.titulo = "",
    this.cuerpo = "",
    this.idSistema = "",
  });

  Map toJson() => {
    'titulo'    : titulo,
    'cuerpo'    : cuerpo,
    'idSistema' : idSistema,
  };
}