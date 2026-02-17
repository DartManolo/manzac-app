// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reporte_imagenes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReporteImagenesAdapter extends TypeAdapter<ReporteImagenes> {
  @override
  final typeId = 5;

  @override
  ReporteImagenes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReporteImagenes(
      idTarja: fields[1] == null ? "" : fields[1] as String?,
      idImagen: fields[2] == null ? "" : fields[2] as String?,
      formato: fields[3] == null ? "" : fields[3] as String?,
      fila: fields[4] == null ? 0 : (fields[4] as num?)?.toInt(),
      posicion: fields[5] == null ? 0 : (fields[5] as num?)?.toInt(),
      imagen: fields[6] == null ? "" : fields[6] as String?,
      tipo: fields[7] == null ? "" : fields[7] as String?,
      usuario: fields[8] == null ? "" : fields[8] as String?,
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, ReporteImagenes obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idTarja)
      ..writeByte(2)
      ..write(obj.idImagen)
      ..writeByte(3)
      ..write(obj.formato)
      ..writeByte(4)
      ..write(obj.fila)
      ..writeByte(5)
      ..write(obj.posicion)
      ..writeByte(6)
      ..write(obj.imagen)
      ..writeByte(7)
      ..write(obj.tipo)
      ..writeByte(8)
      ..write(obj.usuario);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReporteImagenesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
