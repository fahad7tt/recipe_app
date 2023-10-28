// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SignupDetailsAdapter extends TypeAdapter<SignupDetails> {
  @override
  final int typeId = 0;

  @override
  SignupDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SignupDetails(
      username: fields[0] as String,
      email: fields[1] as String,
      password: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SignupDetails obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignupDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// class AddRecipeDetailsAdapter extends TypeAdapter<AddRecipeDetails> {
//   @override
//   final int typeId = 1;

//   @override
//   AddRecipeDetails read(BinaryReader reader) {
//   final numOfFields = reader.readByte();
//   final fields = <int, dynamic>{
//     for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//   };
  
//   final itemName = fields[0] as String?;
//   final duration = fields[1] as String?;
//   final ingredients = fields[2] as String?;
//   final description = fields[3] as String?;
//   final category = fields[4] as String?;
//   final imageUrls = (fields[5] as List<String?>?)?.where((s) => s != null).cast<String>().toList() ?? [];

// //   return AddRecipeDetails(
// //     itemName: itemName ?? '',  // Provide a default value for itemName if it's null
// //     duration: duration ?? '',  // Provide a default value for duration if it's null
// //     ingredients: ingredients ?? '',  // Provide a default value for ingredients if it's null
// //     description: description ?? '',  // Provide a default value for description if it's null
// //     category: category ?? '',  // Provide a default value for category if it's null
// //     imageUrls: imageUrls, // No need for a default value for imageUrls as it's a List
// //   );
// // }


// //   @override
// //   void write(BinaryWriter writer, AddRecipeDetails obj) {
// //     writer
// //       ..writeByte(6)
// //       ..writeByte(0)
// //       ..write(obj.itemName)
// //       ..writeByte(1)
// //       ..write(obj.duration)
// //       ..writeByte(2)
// //       ..write(obj.ingredients)
// //       ..writeByte(3)
// //       ..write(obj.description)
// //       ..writeByte(4)
// //       ..write(obj.category)
// //       ..writeByte(5)
// //       ..write(obj.imageUrls);
// //   }

// //   @override
// //   int get hashCode => typeId.hashCode;

// //   @override
// //   bool operator ==(Object other) =>
// //       identical(this, other) ||
// //       other is AddRecipeDetailsAdapter &&
// //           runtimeType == other.runtimeType &&
// //           typeId == other.typeId;
// // }
