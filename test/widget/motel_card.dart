import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/models/motel.dart';
import 'package:guia_moteis/models/suite.dart';
import 'package:guia_moteis/motel_card.dart';
import 'package:guia_moteis/suites_list.dart';

void main() {
  testWidgets('MotelCard displays correct information',
      (WidgetTester tester) async {
    final motel = Motel(
      fantasia: 'Motel Le Nid',
      logo: 'https://cdn.guiademoteis.com.br/imagens/logotipos/3148-le-nid.gif',
      bairro: 'Chácara Flora - São Paulo',
      distancia: 28.27,
      media: 4.6,
      qtdAvaliacoes: 2159,
      suites: [
        Suite(
          nome: 'Suíte Marselha s/ garagem privativa',
          fotos: [
            'https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_1.jpg',
            'https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_2.jpg'
          ],
          periodos: [
            Periodo(
              temCortesia: false,
              tempo: '12 horas',
              tempoFormatado: '12 horas',
              valor: 100.0,
              valorTotal: 100.0,
            ),
          ],
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MotelCard(motel: motel),
        ),
      ),
    );

    expect(find.text('motel le nid'), findsOneWidget);
    expect(find.text('28.27km'), findsOneWidget);
    expect(find.text(' - Chácara Flora - São Paulo'), findsOneWidget);
    expect(find.text('4.6'), findsOneWidget);
    expect(find.text('2159 avaliações'), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2));
    expect(find.byType(SuitesList), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
  });
}
