import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecobin/core/data/error/exception.dart';
import 'package:ecobin/features/requests/domain/pickup.dart';
import 'package:ecobin/features/requests/domain/repository/pickup_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'pickup_event.dart';
part 'pickup_state.dart';

class PickupBloc extends Bloc<PickupEvent, PickupState> {
  final PickupRepository repository;

  PickupBloc({required this.repository}) : super(PickupInitial()) {
    on<GetPickupEvent>(_getPickup);
    on<CreatePickupEvent>(_createPickup);
    on<GetPickupByIdEvent>(_getPickupById);
  }

  Future<void> _getPickup(
    GetPickupEvent event,
    Emitter<PickupState> emit,
  ) async {
    emit(PickupLoading());
    try {
      final pickup = await repository.getPickup();
      emit(PickupLoaded(pickup));
    } on ServerException catch (e) {
      emit(PickupError(e.message));
    } on NetworkException catch (e) {
      emit(PickupError(e.message));
    } catch (e) {
      emit(PickupError('Failed to load pickup'));
      rethrow;
    }
  }

  Future<void> _createPickup(
    CreatePickupEvent event,
    Emitter<PickupState> emit,
  ) async {
    emit(PickupLoading());
    try {
      await repository.createPickup(
        userId: event.userId,
        address: event.address,
        pickupDate: event.pickupDate,
        pickupTime: event.pickupTime,
      );
      final pickup = await repository.getPickup();
      // add(GetPickupEvent());
      emit(PickupLoaded(pickup));
    } on ServerException catch (e) {
      emit(PickupError(e.message));
    } catch (e) {
      emit(PickupError('Failed to create pickup'));
      rethrow;
    }
  }

  Future<void> _getPickupById(
    GetPickupByIdEvent event,
    Emitter<PickupState> emit,
  ) async {
    emit(PickupLoading());
    try {
      await repository.getPickupById(event.id);
      emit(PickupLoaded([]));
    } catch (e) {
      emit(PickupError('Failed to load pickup'));
      rethrow;
    }
  }
}
