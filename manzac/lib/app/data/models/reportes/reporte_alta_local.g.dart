// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reporte_alta_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReporteAltaLocalAdapter extends TypeAdapter<ReporteAltaLocal> {
  @override
  final typeId = 1;

  @override
  ReporteAltaLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReporteAltaLocal(
      id: fields[0] as String?,
      tipo: fields[1] as String?,
      reporteEntrada: fields[2] as ReporteEntrada?,
      reporteSalida: fields[3] as ReporteSalida?,
      reporteDanio: fields[4] as ReporteDanio?,
    );
  }

  @override
  void write(BinaryWriter writer, ReporteAltaLocal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tipo)
      ..writeByte(2)
      ..write(obj.reporteEntrada)
      ..writeByte(3)
      ..write(obj.reporteSalida)
      ..writeByte(4)
      ..write(obj.reporteDanio);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReporteAltaLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
