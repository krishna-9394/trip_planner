// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trips.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripAdapter extends TypeAdapter<Trip> {
  @override
  final int typeId = 1;

  @override
  Trip read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Trip(
      totalAmount: fields[2] as double,
      usersCount: fields[3] as int,
      tripName: fields[0] as String,
      time: fields[1] as DateTime,
      users: (fields[5] as List).cast<User>(),
    )..transactionsCount = fields[4] as int;
  }

  @override
  void write(BinaryWriter writer, Trip obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.tripName)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.totalAmount)
      ..writeByte(3)
      ..write(obj.usersCount)
      ..writeByte(4)
      ..write(obj.transactionsCount)
      ..writeByte(5)
      ..write(obj.users);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
