// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reporte_entrada.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReporteEntradaAdapter extends TypeAdapter<ReporteEntrada> {
  @override
  final typeId = 2;

  @override
  ReporteEntrada read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReporteEntrada(
      idTarja: fields[1] == null ? "" : fields[1] as String?,
      tipo: fields[2] == null ? "ENTRADA" : fields[2] as String?,
      fecha: fields[3] == null ? "" : fields[3] as String?,
      referenciaLm: fields[4] == null ? "\n" : fields[4] as String?,
      imo: fields[5] == null ? "\n" : fields[5] as String?,
      horaInicio: fields[6] == null ? "\n" : fields[6] as String?,
      horaFin: fields[7] == null ? "\n" : fields[7] as String?,
      cliente: fields[8] == null ? "\n" : fields[8] as String?,
      mercancia: fields[9] == null ? "\n" : fields[9] as String?,
      agenteAduanal: fields[10] == null ? "\n" : fields[10] as String?,
      ejecutivo: fields[11] == null ? "\n" : fields[11] as String?,
      contenedor: fields[12] == null ? "\n" : fields[12] as String?,
      pedimento: fields[13] == null ? "\n" : fields[13] as String?,
      sello: fields[14] == null ? "\n" : fields[14] as String?,
      buque: fields[15] == null ? "\n" : fields[15] as String?,
      refCliente: fields[16] == null ? "\n" : fields[16] as String?,
      bultos: fields[17] == null ? "\n" : fields[17] as String?,
      peso: fields[18] == null ? "\n" : fields[18] as String?,
      terminal: fields[19] == null ? "\n" : fields[19] as String?,
      fechaDespacho: fields[20] == null ? "\n" : fields[20] as String?,
      diasLibres: fields[21] == null ? "\n" : fields[21] as String?,
      fechaVencimiento: fields[22] == null ? "\n" : fields[22] as String?,
      movimiento: fields[23] == null ? "\n" : fields[23] as String?,
      observaciones: fields[25] == null ? "\n" : fields[25] as String?,
      usuario: fields[26] == null ? "" : fields[26] as String?,
      imagenes:
          fields[27] == null
              ? const []
              : (fields[27] as List?)?.cast<ReporteImagenes>(),
      nombreUsuario: fields[28] == null ? "" : fields[28] as String?,
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, ReporteEntrada obj) {
    writer
      ..writeByte(28)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idTarja)
      ..writeByte(2)
      ..write(obj.tipo)
      ..writeByte(3)
      ..write(obj.fecha)
      ..writeByte(4)
      ..write(obj.referenciaLm)
      ..writeByte(5)
      ..write(obj.imo)
      ..writeByte(6)
      ..write(obj.horaInicio)
      ..writeByte(7)
      ..write(obj.horaFin)
      ..writeByte(8)
      ..write(obj.cliente)
      ..writeByte(9)
      ..write(obj.mercancia)
      ..writeByte(10)
      ..write(obj.agenteAduanal)
      ..writeByte(11)
      ..write(obj.ejecutivo)
      ..writeByte(12)
      ..write(obj.contenedor)
      ..writeByte(13)
      ..write(obj.pedimento)
      ..writeByte(14)
      ..write(obj.sello)
      ..writeByte(15)
      ..write(obj.buque)
      ..writeByte(16)
      ..write(obj.refCliente)
      ..writeByte(17)
      ..write(obj.bultos)
      ..writeByte(18)
      ..write(obj.peso)
      ..writeByte(19)
      ..write(obj.terminal)
      ..writeByte(20)
      ..write(obj.fechaDespacho)
      ..writeByte(21)
      ..write(obj.diasLibres)
      ..writeByte(22)
      ..write(obj.fechaVencimiento)
      ..writeByte(23)
      ..write(obj.movimiento)
      ..writeByte(25)
      ..write(obj.observaciones)
      ..writeByte(26)
      ..write(obj.usuario)
      ..writeByte(27)
      ..write(obj.imagenes)
      ..writeByte(28)
      ..write(obj.nombreUsuario);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReporteEntradaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
