import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/models/suite.dart';
import 'package:guia_moteis/suites_list.dart';

void main() {
  testWidgets('SuitesList displays correct information',
      (WidgetTester tester) async {
    final suites = [
      Suite(
        nome: 'Test Suite',
        fotos: ['https://example.com/test.jpg'],
        periodos: [
          Periodo(
            temCortesia: false,
            tempo: '3 horas',
            tempoFormatado: '3 horas',
            valor: 100.0,
            valorTotal: 90.0,
            desconto: Desconto(desconto: 10.0),
          ),
        ],
        categoriaItens: [
          CategoryItem(nome: 'WiFi', icone: 'https://example.com/wifi.png'),
        ],
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SuitesList(suites: suites),
        ),
      ),
    );

    expect(find.text('test suite'), findsOneWidget);
    expect(find.text('3 horas'), findsOneWidget);
    expect(find.text('R\$ 100.00'), findsOneWidget);
    expect(find.text('R\$ 90.00'), findsOneWidget);
    expect(find.text('10% off'), findsOneWidget);
    expect(find.text('ver\ntodos'), findsOneWidget);
    expect(
      find.byType(Image),
      findsNWidgets(2),
    ); // Suite image and category item icon
  });
}
