// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customers_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomersListModelAdapter extends TypeAdapter<CustomersListModel> {
  @override
  final int typeId = 2;

  @override
  CustomersListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomersListModel(
      id: fields[1] as int?,
      name: fields[2] as String?,
      profilePic: fields[3] as String?,
      mobileNumber: fields[4] as String?,
      email: fields[5] as String?,
      street: fields[6] as String?,
      streetTwo: fields[7] as String?,
      city: fields[8] as String?,
      pincode: fields[9] as int?,
      country: fields[10] as String?,
      state: fields[11] as String?,
      createdDate: fields[12] as DateTime?,
      createdTime: fields[13] as String?,
      modifiedDate: fields[14] as DateTime?,
      modifiedTime: fields[15] as String?,
      flag: fields[16] as bool?,
      imageBytes: fields[17] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, CustomersListModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.profilePic)
      ..writeByte(4)
      ..write(obj.mobileNumber)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.street)
      ..writeByte(7)
      ..write(obj.streetTwo)
      ..writeByte(8)
      ..write(obj.city)
      ..writeByte(9)
      ..write(obj.pincode)
      ..writeByte(10)
      ..write(obj.country)
      ..writeByte(11)
      ..write(obj.state)
      ..writeByte(12)
      ..write(obj.createdDate)
      ..writeByte(13)
      ..write(obj.createdTime)
      ..writeByte(14)
      ..write(obj.modifiedDate)
      ..writeByte(15)
      ..write(obj.modifiedTime)
      ..writeByte(16)
      ..write(obj.flag)
      ..writeByte(17)
      ..write(obj.imageBytes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomersListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
