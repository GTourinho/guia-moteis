import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_moteis/bloc/motel_state.dart';
import 'package:guia_moteis/models/motel.dart';
import 'package:guia_moteis/repository/motel_repository.dart';

import 'motel_event.dart';

class MotelBloc extends Bloc<MotelEvent, MotelState> {
  final MotelRepository repository;

  MotelBloc(this.repository) : super(MotelInitial()) {
    on<FetchMotels>(_onFetchMotels);
    on<UpdateFilters>(_onUpdateFilters);
  }

  void _onFetchMotels(FetchMotels event, Emitter<MotelState> emit) async {
    emit(MotelLoading());
    try {
      final motelsData = await repository.fetchMotels();
      final motels = motelsData['data']['moteis']
          .map<Motel>((json) => Motel.fromJson(json))
          .toList();

      final availableFilters = _getAvailableFilters(motels);

      emit(MotelLoaded(
        allMotels: motels,
        filteredMotels: motels,
        availableFilters: availableFilters,
        activeFilters: const {},
      ));
    } catch (e) {
      emit(MotelError(e.toString()));
    }
  }

  void _onUpdateFilters(UpdateFilters event, Emitter<MotelState> emit) {
    if (state is MotelLoaded) {
      final currentState = state as MotelLoaded;
      emit(MotelLoading());

      final filteredMotels =
          _filterMotelsAndSuites(currentState.allMotels, event.filters);

      emit(MotelLoaded(
        allMotels: currentState.allMotels,
        filteredMotels: filteredMotels,
        availableFilters: currentState.availableFilters,
        activeFilters: event.filters,
      ));
    }
  }

  Set<String> _getAvailableFilters(List<Motel> motels) {
    return motels
        .expand((motel) => motel.suites
            .expand((suite) => suite.categoriaItens)
            .map((item) => item.nome))
        .toSet();
  }

  List<Motel> _filterMotelsAndSuites(List<Motel> motels, Set<String> filters) {
    if (filters.isEmpty) return motels;

    return motels
        .map((motel) {
          final filteredSuites = motel.suites.where((suite) {
            return suite.categoriaItens
                .any((item) => filters.contains(item.nome));
          }).toList();

          return filteredSuites.isNotEmpty
              ? motel.copyWith(suites: filteredSuites)
              : null;
        })
        .whereType<Motel>()
        .toList();
  }
}
