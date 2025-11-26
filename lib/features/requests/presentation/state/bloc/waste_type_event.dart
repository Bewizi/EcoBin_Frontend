part of 'waste_type_bloc.dart';

@immutable
sealed class WasteTypeEvent extends Equatable {
  const WasteTypeEvent();

  @override
  List<Object> get props => [];
}

class GetWasteTypesEvent extends WasteTypeEvent {
  const GetWasteTypesEvent();

  @override
  List<Object> get props => [];
}

class GetWasteCategoryByIdEvent extends WasteTypeEvent {
  final String id;

  const GetWasteCategoryByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}
