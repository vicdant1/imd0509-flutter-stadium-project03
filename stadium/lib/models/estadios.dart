// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'estadios.g.dart';

@JsonSerializable()
class Estadios {
  final String nome;
  final String imagem;
  final String descricao;
  final String localizacao;
  final String endereco;
  final double lat;
  final double long;
  final String clubId;
  final String clubNome;
  final String? capacidade;
  Estadios({
    required this.nome,
    required this.imagem,
    required this.descricao,
    required this.localizacao,
    required this.endereco,
    required this.lat,
    required this.long,
    required this.clubId,
    required this.clubNome,
    this.capacidade,
  });

  factory Estadios.fromJson(Map<String, dynamic> json) =>
      _$EstadiosFromJson(json);

  Map<String, dynamic> toJson() => _$EstadiosToJson(this);
}
