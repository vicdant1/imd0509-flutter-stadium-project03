// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:stadium/models/jogadores.dart';

part 'clubes.g.dart';

@JsonSerializable()
class Clubes {
  String id;
  String nome;
  String imagem;
  int quantidadeTitulos;
  List<Jogador>? jogadores;
  Clubes({
    this.id = '',
    required this.nome,
    required this.imagem,
    required this.quantidadeTitulos,
    this.jogadores,
  });

  factory Clubes.fromJson(Map<String, dynamic> json) => _$ClubesFromJson(json);
  Map<String, dynamic> toJson() => _$ClubesToJson(this);
}
