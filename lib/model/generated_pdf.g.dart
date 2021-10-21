// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generated_pdf.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GeneratedPdfAdapter extends TypeAdapter<GeneratedPdf> {
  @override
  final int typeId = 0;

  @override
  GeneratedPdf read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GeneratedPdf()
      ..path = (fields[0] as List?)?.cast<String>()
      ..name = fields[1] as String?
      ..dateTime = fields[2] as DateTime
      ..pDFpath = fields[3] as String?;
  }

  @override
  void write(BinaryWriter writer, GeneratedPdf obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.path)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.pDFpath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeneratedPdfAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
