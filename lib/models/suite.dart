class Suite {
  final String nome;
  final List<String> fotos;
  final List<Periodo> periodos;
  final List<CategoryItem> categoriaItens;
  final List<Item> itens;
  final int qtd;
  final bool exibirQtdDisponiveis;

  Suite({
    required this.nome,
    required this.fotos,
    required this.periodos,
    this.qtd = 0,
    this.exibirQtdDisponiveis = false,
    this.categoriaItens = const [],
    this.itens = const [],
  });

  factory Suite.fromJson(Map<String, dynamic> json) {
    return Suite(
      nome: json['nome'],
      fotos: List<String>.from(json['fotos']),
      periodos: List<Periodo>.from(
        json['periodos'].map((periodo) => Periodo.fromJson(periodo)),
      ),
      categoriaItens: List<CategoryItem>.from(
          json['categoriaItens'].map((item) => CategoryItem.fromJson(item))),
      itens: List<Item>.from(json['itens'].map((item) => Item.fromJson(item))),
      qtd: json['qtd'] ?? 0,
      exibirQtdDisponiveis: json['exibirQtdDisponiveis'] ?? false,
    );
  }
}

class CategoryItem {
  final String nome;
  final String icone;

  CategoryItem({
    required this.nome,
    required this.icone,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      nome: json['nome'],
      icone: json['icone'],
    );
  }
}

class Item {
  final String nome;

  Item({
    required this.nome,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      nome: json['nome'],
    );
  }
}

class Periodo {
  final String tempoFormatado;
  final String tempo;
  final double valor;
  final double valorTotal;
  final bool temCortesia;
  final Desconto? desconto;

  Periodo({
    required this.tempoFormatado,
    required this.tempo,
    required this.valor,
    required this.valorTotal,
    this.temCortesia = false,
    this.desconto,
  });

  factory Periodo.fromJson(Map<String, dynamic> json) {
    return Periodo(
      tempoFormatado: json['tempoFormatado'],
      tempo: json['tempo'],
      valor: json['valor'],
      valorTotal: json['valorTotal'],
      temCortesia: json['temCortesia'],
      desconto:
          json['desconto'] != null ? Desconto.fromJson(json['desconto']) : null,
    );
  }
}

class Desconto {
  final double desconto;

  Desconto({
    required this.desconto,
  });

  factory Desconto.fromJson(Map<String, dynamic> json) {
    return Desconto(
      desconto: json['desconto'],
    );
  }
}
