// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductListModelAdapter extends TypeAdapter<ProductListModel> {
  @override
  final int typeId = 1;

  @override
  ProductListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductListModel(
      id: fields[1] as int?,
      name: fields[2] as String?,
      image: fields[3] as String?,
      price: fields[4] as int?,
      createdDate: fields[5] as DateTime?,
      createdTime: fields[6] as String?,
      modifiedDate: fields[7] as DateTime?,
      modifiedTime: fields[8] as String?,
      flag: fields[9] as bool?,
      imageBytes: fields[10] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductListModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.createdDate)
      ..writeByte(6)
      ..write(obj.createdTime)
      ..writeByte(7)
      ..write(obj.modifiedDate)
      ..writeByte(8)
      ..write(obj.modifiedTime)
      ..writeByte(9)
      ..write(obj.flag)
      ..writeByte(10)
      ..write(obj.imageBytes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
