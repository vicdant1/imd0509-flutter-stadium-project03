// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estadios.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Estadios _$EstadiosFromJson(Map<String, dynamic> json) => Estadios(
      nome: json['nome'] as String,
      imagem: json['imagem'] as String,
      descricao: json['descricao'] as String,
      localizacao: json['localizacao'] as String,
      endereco: json['endereco'] as String,
      lat: (json['lat'] as num).toDouble(),
      long: (json['long'] as num).toDouble(),
      clubId: json['clubId'] as String,
      clubNome: json['clubNome'] as String,
      capacidade: json['capacidade'] as String?,
    );

Map<String, dynamic> _$EstadiosToJson(Estadios instance) => <String, dynamic>{
      'nome': instance.nome,
      'imagem': instance.imagem,
      'descricao': instance.descricao,
      'localizacao': instance.localizacao,
      'endereco': instance.endereco,
      'lat': instance.lat,
      'long': instance.long,
      'clubId': instance.clubId,
      'clubNome': instance.clubNome,
      'capacidade': instance.capacidade,
    };
