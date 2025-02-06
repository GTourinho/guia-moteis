import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_moteis/main.dart';
import 'package:guia_moteis/bloc/bloc.dart';
import 'package:guia_moteis/models/motel.dart';
import 'package:guia_moteis/models/suite.dart';
import 'package:guia_moteis/motel_card.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'main.mocks.dart';

@GenerateNiceMocks([MockSpec<MotelBloc>()])
void main() {
  Widget createSubject(MockMotelBloc mockBloc) {
    return MaterialApp(
      home: BlocProvider<MotelBloc>.value(
        value: mockBloc,
        child: const HomePage(),
      ),
    );
  }

  testWidgets('It should render HomePage with AppBar', (tester) async {
    final mockMotelBloc = MockMotelBloc();
    when(mockMotelBloc.state).thenReturn(MotelInitial());

    await tester.pumpWidget(createSubject(mockMotelBloc));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('ir agora'), findsOneWidget);
    expect(find.text('ir outro dia'), findsOneWidget);
  });

  testWidgets('It should show loading indicator when state is MotelLoading',
      (tester) async {
    final mockMotelBloc = MockMotelBloc();
    when(mockMotelBloc.state).thenReturn(MotelLoading());

    await tester.pumpWidget(createSubject(mockMotelBloc));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('It should show error message when state is MotelError',
      (tester) async {
    final mockMotelBloc = MockMotelBloc();
    when(mockMotelBloc.state).thenReturn(const MotelError('Error message'));

    await tester.pumpWidget(createSubject(mockMotelBloc));

    expect(find.text('Error message'), findsOneWidget);
  });

  testWidgets('It should render motel list when state is MotelLoaded',
      (tester) async {
    final mockMotelBloc = MockMotelBloc();
    final testMotel = Motel(
        fantasia: 'Test Motel',
        logo: 'test_logo.png',
        bairro: 'Test Bairro',
        distancia: 2.5,
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
        media: 4.5,
        qtdAvaliacoes: 100);

    when(mockMotelBloc.state).thenReturn(MotelLoaded(
      allMotels: [testMotel],
      filteredMotels: [testMotel],
      activeFilters: const {},
      availableFilters: const {'Filter1'},
    ));

    await tester.pumpWidget(createSubject(mockMotelBloc));

    expect(find.byType(MotelCard), findsOneWidget);
    expect(find.text('test motel'), findsOneWidget);
    expect(find.byType(FilterChip), findsNWidgets(2));
    expect(find.text('filter1'), findsOneWidget);
  });
}
