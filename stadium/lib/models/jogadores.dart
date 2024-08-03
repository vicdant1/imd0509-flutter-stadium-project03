// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'jogadores.g.dart';

@JsonSerializable()
class Jogador {
  String nome;
  String posicao;

  Jogador({
    required this.nome,
    required this.posicao,
  });

  factory Jogador.fromJson(Map<String, dynamic> json) =>
      _$JogadorFromJson(json);
  Map<String, dynamic> toJson() => _$JogadorToJson(this);
}
