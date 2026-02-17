// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reporte_danio.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReporteDanioAdapter extends TypeAdapter<ReporteDanio> {
  @override
  final typeId = 4;

  @override
  ReporteDanio read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReporteDanio(
      idTarja: fields[1] == null ? "" : fields[1] as String?,
      tipo: fields[2] == null ? "DAÑOS" : fields[2] as String?,
      fecha: fields[3] == null ? "" : fields[3] as String?,
      fechaCreado: fields[4] == null ? "" : fields[4] as String?,
      version: fields[5] == null ? "" : fields[5] as String?,
      clave: fields[6] == null ? "" : fields[6] as String?,
      fechaReporte: fields[7] == null ? "" : fields[7] as String?,
      lineaNaviera: fields[8] == null ? "" : fields[8] as String?,
      cliente: fields[9] == null ? "" : fields[9] as String?,
      numContenedor: fields[10] == null ? "" : fields[10] as String?,
      vacio: fields[11] == null ? "" : fields[11] as String?,
      lleno: fields[12] == null ? "" : fields[12] as String?,
      d20: fields[13] == null ? "" : fields[13] as String?,
      d40: fields[14] == null ? "" : fields[14] as String?,
      hc: fields[15] == null ? "" : fields[15] as String?,
      otro: fields[16] == null ? "" : fields[16] as String?,
      estandar: fields[17] == null ? "" : fields[17] as String?,
      opentop: fields[18] == null ? "" : fields[18] as String?,
      flatRack: fields[19] == null ? "" : fields[19] as String?,
      reefer: fields[20] == null ? "" : fields[20] as String?,
      reforzado: fields[21] == null ? "" : fields[21] as String?,
      numSello: fields[22] == null ? "" : fields[22] as String?,
      intPuertasIzq: fields[23] == null ? "" : fields[23] as String?,
      intPuertasDer: fields[24] == null ? "" : fields[24] as String?,
      intPiso: fields[25] == null ? "" : fields[25] as String?,
      intTecho: fields[26] == null ? "" : fields[26] as String?,
      intPanelLateralIzq: fields[27] == null ? "" : fields[27] as String?,
      intPanelLateralDer: fields[28] == null ? "" : fields[28] as String?,
      intPanelFondo: fields[29] == null ? "" : fields[29] as String?,
      extPuertasIzq: fields[30] == null ? "" : fields[30] as String?,
      extPuertasDer: fields[31] == null ? "" : fields[31] as String?,
      extPoste: fields[32] == null ? "" : fields[32] as String?,
      extPalanca: fields[33] == null ? "" : fields[33] as String?,
      extGanchoCierre: fields[34] == null ? "" : fields[34] as String?,
      extPanelIzq: fields[35] == null ? "" : fields[35] as String?,
      extPanelDer: fields[36] == null ? "" : fields[36] as String?,
      extPanelFondo: fields[37] == null ? "" : fields[37] as String?,
      extCantonera: fields[38] == null ? "" : fields[38] as String?,
      extFrisa: fields[39] == null ? "" : fields[39] as String?,
      observaciones: fields[40] == null ? "" : fields[40] as String?,
      usuario: fields[41] == null ? "" : fields[41] as String?,
      imagenes:
          fields[42] == null
              ? const []
              : (fields[42] as List?)?.cast<ReporteImagenes>(),
      nombreUsuario: fields[43] == null ? "" : fields[43] as String?,
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, ReporteDanio obj) {
    writer
      ..writeByte(44)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idTarja)
      ..writeByte(2)
      ..write(obj.tipo)
      ..writeByte(3)
      ..write(obj.fecha)
      ..writeByte(4)
      ..write(obj.fechaCreado)
      ..writeByte(5)
      ..write(obj.version)
      ..writeByte(6)
      ..write(obj.clave)
      ..writeByte(7)
      ..write(obj.fechaReporte)
      ..writeByte(8)
      ..write(obj.lineaNaviera)
      ..writeByte(9)
      ..write(obj.cliente)
      ..writeByte(10)
      ..write(obj.numContenedor)
      ..writeByte(11)
      ..write(obj.vacio)
      ..writeByte(12)
      ..write(obj.lleno)
      ..writeByte(13)
      ..write(obj.d20)
      ..writeByte(14)
      ..write(obj.d40)
      ..writeByte(15)
      ..write(obj.hc)
      ..writeByte(16)
      ..write(obj.otro)
      ..writeByte(17)
      ..write(obj.estandar)
      ..writeByte(18)
      ..write(obj.opentop)
      ..writeByte(19)
      ..write(obj.flatRack)
      ..writeByte(20)
      ..write(obj.reefer)
      ..writeByte(21)
      ..write(obj.reforzado)
      ..writeByte(22)
      ..write(obj.numSello)
      ..writeByte(23)
      ..write(obj.intPuertasIzq)
      ..writeByte(24)
      ..write(obj.intPuertasDer)
      ..writeByte(25)
      ..write(obj.intPiso)
      ..writeByte(26)
      ..write(obj.intTecho)
      ..writeByte(27)
      ..write(obj.intPanelLateralIzq)
      ..writeByte(28)
      ..write(obj.intPanelLateralDer)
      ..writeByte(29)
      ..write(obj.intPanelFondo)
      ..writeByte(30)
      ..write(obj.extPuertasIzq)
      ..writeByte(31)
      ..write(obj.extPuertasDer)
      ..writeByte(32)
      ..write(obj.extPoste)
      ..writeByte(33)
      ..write(obj.extPalanca)
      ..writeByte(34)
      ..write(obj.extGanchoCierre)
      ..writeByte(35)
      ..write(obj.extPanelIzq)
      ..writeByte(36)
      ..write(obj.extPanelDer)
      ..writeByte(37)
      ..write(obj.extPanelFondo)
      ..writeByte(38)
      ..write(obj.extCantonera)
      ..writeByte(39)
      ..write(obj.extFrisa)
      ..writeByte(40)
      ..write(obj.observaciones)
      ..writeByte(41)
      ..write(obj.usuario)
      ..writeByte(42)
      ..write(obj.imagenes)
      ..writeByte(43)
      ..write(obj.nombreUsuario);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReporteDanioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
