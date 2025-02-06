import 'package:equatable/equatable.dart';
import 'package:guia_moteis/models/motel.dart';

abstract class MotelState extends Equatable {
  const MotelState();

  @override
  List<Object> get props => [];
}

class MotelInitial extends MotelState {}

class MotelLoading extends MotelState {}

class MotelLoaded extends MotelState {
  final List<Motel> allMotels;
  final List<Motel> filteredMotels;
  final Set<String> availableFilters;
  final Set<String> activeFilters;

  const MotelLoaded({
    required this.allMotels,
    required this.filteredMotels,
    required this.availableFilters,
    required this.activeFilters,
  });

  @override
  List<Object> get props =>
      [allMotels, filteredMotels, availableFilters, activeFilters];
}

class MotelError extends MotelState {
  final String message;

  const MotelError(this.message);

  @override
  List<Object> get props => [message];
}
