import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/bloc/bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:guia_moteis/repository/motel_repository.dart';
import 'bloc_test.mocks.dart';

@GenerateMocks([MotelBloc, MotelRepository])
void main() {
  late MotelBloc bloc;
  late MockMotelRepository repository;

  setUp(() {
    repository = MockMotelRepository();
    bloc = MotelBloc(repository);
  });

  final testMotels = {
    'sucesso': true,
    'data': {
      'moteis': [
        {
          'fantasia': 'Motel Le Nid',
          'logo':
              'https://cdn.guiademoteis.com.br/imagens/logotipos/3148-le-nid.gif',
          'bairro': 'Chácara Flora - São Paulo',
          'distancia': 28.27,
          'qtdAvaliacoes': 2159,
          'media': 4.6,
          'suites': [
            {
              'nome': 'Suíte Marselha s/ garagem privativa',
              'fotos': [
                'https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_1.jpg',
                'https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_2.jpg'
              ],
              'periodos': [
                {
                  'tempoFormatado': '3 horas',
                  'tempo': '3',
                  'valor': 88.0,
                  'valorTotal': 88.0,
                  'temCortesia': false,
                  'desconto': null
                },
                {
                  'tempoFormatado': '6 horas',
                  'tempo': '6',
                  'valor': 101.0,
                  'valorTotal': 101.0,
                  'temCortesia': false,
                  'desconto': null
                }
              ],
              'categoriaItens': [
                {
                  'nome': 'Frigobar',
                  'icone':
                      'https://cdn.guiademoteis.com.br/Images/itens-suites/frigobar-04-09-2018-12-14.png'
                },
                {
                  'nome': 'Ar-Condicionado',
                  'icone':
                      'https://cdn.guiademoteis.com.br/Images/itens-suites/arcondicionado-04-09-2018-12-13.png'
                }
              ],
              'itens': [
                {'nome': 'ducha dupla'},
                {'nome': 'TV a cabo'}
              ]
            }
          ]
        }
      ]
    }
  };

  blocTest<MotelBloc, MotelState>(
    'emits [MotelLoading, MotelLoaded] when successful',
    setUp: () {
      when(repository.fetchMotels()).thenAnswer((_) async => testMotels);
    },
    build: () => bloc,
    act: (bloc) => bloc.add(FetchMotels()),
    expect: () => [
      isA<MotelLoading>(),
      isA<MotelLoaded>(),
    ],
  );

  blocTest<MotelBloc, MotelState>(
    'emits [MotelLoading, MotelError] when error',
    setUp: () {
      when(repository.fetchMotels())
          .thenThrow(Exception('Error fetching motels'));
    },
    build: () => bloc,
    act: (bloc) => bloc.add(FetchMotels()),
    expect: () => [
      isA<MotelLoading>(),
      isA<MotelError>(),
    ],
  );

  blocTest<MotelBloc, MotelState>(
    'emits updated MotelLoaded state when UpdateFilters event is added',
    setUp: () {
      when(repository.fetchMotels()).thenAnswer((_) async => testMotels);
    },
    build: () => bloc,
    act: (bloc) async {
      bloc.add(FetchMotels());
      await Future.delayed(Duration.zero);
      bloc.add(const UpdateFilters({'WiFi'}));
    },
    expect: () => [
      isA<MotelLoading>(),
      isA<MotelLoaded>(),
      isA<MotelLoading>(),
      isA<MotelLoaded>().having(
        (state) => state.activeFilters,
        'activeFilters',
        equals({'WiFi'}),
      ),
    ],
    verify: (bloc) {
      expect(bloc.state, isA<MotelLoaded>());
      final state = bloc.state as MotelLoaded;
      expect(state.activeFilters, {'WiFi'});
    },
  );
}
