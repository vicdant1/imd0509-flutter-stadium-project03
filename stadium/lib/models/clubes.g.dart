// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clubes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Clubes _$ClubesFromJson(Map<String, dynamic> json) => Clubes(
      id: json['id'] as String? ?? '',
      nome: json['nome'] as String,
      imagem: json['imagem'] as String,
      quantidadeTitulos: (json['quantidadeTitulos'] as num).toInt(),
      jogadores: (json['jogadores'] as List<dynamic>?)
          ?.map((e) => Jogador.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClubesToJson(Clubes instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'imagem': instance.imagem,
      'quantidadeTitulos': instance.quantidadeTitulos,
      'jogadores': instance.jogadores,
    };
