// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_storage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalStorageAdapter extends TypeAdapter<LocalStorage> {
  @override
  final typeId = 0;

  @override
  LocalStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalStorage(
      id: fields[0] as String?,
      version: fields[1] == null ? 1 : (fields[1] as num?)?.toInt(),
      login: fields[2] == null ? false : fields[2] as bool?,
      idUsuario: fields[3] == null ? "" : fields[3] as String?,
      usuario: fields[4] == null ? "" : fields[4] as String?,
      password: fields[5] == null ? "" : fields[5] as String?,
      perfil: fields[6] == null ? "" : fields[6] as String?,
      nombre: fields[7] == null ? "" : fields[7] as String?,
      token: fields[8] == null ? "-" : fields[8] as String?,
      mayusculas: fields[9] == null ? true : fields[9] as bool?,
      firmaOperaciones: fields[10] == null ? "" : fields[10] as String?,
      firmaGerencia: fields[11] == null ? "" : fields[11] as String?,
      idFirebase: fields[12] == null ? "" : fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalStorage obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.version)
      ..writeByte(2)
      ..write(obj.login)
      ..writeByte(3)
      ..write(obj.idUsuario)
      ..writeByte(4)
      ..write(obj.usuario)
      ..writeByte(5)
      ..write(obj.password)
      ..writeByte(6)
      ..write(obj.perfil)
      ..writeByte(7)
      ..write(obj.nombre)
      ..writeByte(8)
      ..write(obj.token)
      ..writeByte(9)
      ..write(obj.mayusculas)
      ..writeByte(10)
      ..write(obj.firmaOperaciones)
      ..writeByte(11)
      ..write(obj.firmaGerencia)
      ..writeByte(12)
      ..write(obj.idFirebase);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalStorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
