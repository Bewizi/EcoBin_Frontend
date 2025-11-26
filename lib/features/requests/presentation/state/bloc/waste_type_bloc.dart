import 'package:bloc/bloc.dart';
import 'package:ecobin/core/data/error/exception.dart';
import 'package:ecobin/features/requests/domain/repository/waste_type_repository.dart';
import 'package:ecobin/features/requests/domain/waste_categories.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'waste_type_event.dart';
part 'waste_type_state.dart';

class WasteTypeBloc extends Bloc<WasteTypeEvent, WasteTypeState> {
  final WasteTypeRepository repository;

  WasteTypeBloc({required this.repository}) : super(WasteTypeInitial()) {
    on<GetWasteTypesEvent>(_onGetWasteTypes);
    on<GetWasteCategoryByIdEvent>(_onGetWasteCategoryById);
  }

  Future<void> _onGetWasteTypes(
    GetWasteTypesEvent event,
    Emitter<WasteTypeState> emit,
  ) async {
    emit(WasteTypeLoading());
    try {
      final types = await repository.getWasteTypes();
      emit(WasteTypeLoaded(types));
    } on ServerException catch (e) {
      emit(WasteTypeError(e.message));
    } catch (e) {
      emit(WasteTypeError('Failed to load waste types'));
      rethrow;
    }
  }

  Future<void> _onGetWasteCategoryById(
    GetWasteCategoryByIdEvent event,
    Emitter<WasteTypeState> emit,
  ) async {
    emit(WasteTypeLoading());
    try {
      final category = await repository.getWasteCategoryById(event.id);
      // When requesting a specific category by id we emit WasteTypeLoadId so
      // the UI can easily handle a single category response.
      emit(WasteTypeLoadId(category));
    } on ServerException catch (e) {
      emit(WasteTypeError(e.message));
    } catch (e) {
      emit(WasteTypeError('Failed to load waste category'));
      rethrow;
    }
  }
}
