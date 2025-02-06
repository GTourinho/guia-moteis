import 'package:equatable/equatable.dart';

abstract class MotelEvent extends Equatable {
  const MotelEvent();

  @override
  List<Object> get props => [];
}

class FetchMotels extends MotelEvent {}

class UpdateFilters extends MotelEvent {
  final Set<String> filters;

  const UpdateFilters(this.filters);

  @override
  List<Object> get props => [filters];
}
