import 'package:guia_moteis/models/suite.dart';

class Motel {
  final String fantasia;
  final String logo;
  final String bairro;
  final double distancia;
  final List<Suite> suites;
  final double media;
  final int qtdAvaliacoes;

  Motel({
    required this.fantasia,
    required this.logo,
    required this.bairro,
    required this.distancia,
    required this.suites,
    this.media = 0.0,
    this.qtdAvaliacoes = 0,
  });

  Motel copyWith({
    String? fantasia,
    String? logo,
    String? bairro,
    double? distancia,
    List<Suite>? suites,
    double? media,
    int? qtdAvaliacoes,
  }) {
    return Motel(
      fantasia: fantasia ?? this.fantasia,
      logo: logo ?? this.logo,
      bairro: bairro ?? this.bairro,
      distancia: distancia ?? this.distancia,
      suites: suites ?? this.suites,
      media: media ?? this.media,
      qtdAvaliacoes: qtdAvaliacoes ?? this.qtdAvaliacoes,
    );
  }

  factory Motel.fromJson(Map<String, dynamic> json) {
    return Motel(
      fantasia: json['fantasia'],
      logo: json['logo'],
      bairro: json['bairro'],
      distancia: json['distancia'],
      suites: (json['suites'] as List)
          .map((suite) => Suite.fromJson(suite))
          .toList(),
      media: json['media'],
      qtdAvaliacoes: json['qtdAvaliacoes'],
    );
  }
}
