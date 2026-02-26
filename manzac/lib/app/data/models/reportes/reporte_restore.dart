class ReporteRestore {
  String? idStorage;
  String? idTarja;
  bool correcto;

  ReporteRestore({
    this.idStorage = '',
    this.idTarja = '',
    this.correcto = false,
  });

  Map<String, dynamic> toJson() => {
    'idStorage' : idStorage,
    'idTarja'   : idTarja,
    'correcto'  : correcto,
  };
}