// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      json['email'] as String,
      json['senha'] as String,
      json['base64Perfil'] as String,
    );

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'email': instance.email,
      'senha': instance.senha,
      'base64Perfil': instance.base64Perfil,
    };
