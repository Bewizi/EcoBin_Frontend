part of 'waste_type_bloc.dart';

@immutable
sealed class WasteTypeState {}

final class WasteTypeInitial extends WasteTypeState {}

final class WasteTypeLoading extends WasteTypeState {}

final class WasteTypeLoaded extends WasteTypeState {
  final List<WasteCategories> types;

  WasteTypeLoaded(this.types);
}

final class WasteTypeLoadId extends WasteTypeState {
  final WasteCategories category;

  WasteTypeLoadId(this.category);
}

final class WasteTypeError extends WasteTypeState {
  final String message;

  WasteTypeError(this.message);
}
