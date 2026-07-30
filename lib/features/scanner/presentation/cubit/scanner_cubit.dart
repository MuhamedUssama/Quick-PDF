import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/group_entity.dart';
import '../../domain/usecases/add_image_to_group_usecase.dart';
import '../../domain/usecases/create_group_usecase.dart';
import 'scanner_state.dart';

@injectable
class ScannerCubit extends Cubit<ScannerState> {
  final CreateGroupUseCase _createGroupUseCase;
  final AddImageToGroupUseCase _addImageToGroupUseCase;

  ScannerCubit(this._createGroupUseCase, this._addImageToGroupUseCase)
    : super(const ScannerState());

  Future<void> startNewSession(String initialGroupName) async {
    emit(state.copyWith(status: ScannerStatus.loading, errorMessage: null));
    try {
      final newGroup = await _createGroupUseCase(groupName: initialGroupName);
      emit(
        state.copyWith(
          status: ScannerStatus.ready,
          currentGroup: newGroup,
          sessionGroups: [newGroup],
          currentGroupImageCount: 0,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: ScannerStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> capturePhoto(String tempImagePath) async {
    final group = state.currentGroup;
    if (group == null) {
      emit(
        state.copyWith(
          status: ScannerStatus.error,
          errorMessage: 'No active group found to save image.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: ScannerStatus.capturing));
    try {
      final updatedGroup = await _addImageToGroupUseCase(
        groupId: group.id,
        imagePath: tempImagePath,
      );

      final updatedSessionGroups = state.sessionGroups.map((g) {
        return g.id == updatedGroup.id ? updatedGroup : g;
      }).toList();

      emit(
        state.copyWith(
          status: ScannerStatus.ready,
          currentGroup: updatedGroup,
          sessionGroups: updatedSessionGroups,
          currentGroupImageCount: updatedGroup.images.length,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: ScannerStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> switchToNewGroup(String newGroupName) async {
    emit(state.copyWith(status: ScannerStatus.loading));
    try {
      final newGroup = await _createGroupUseCase(groupName: newGroupName);
      final updatedSessionGroups = List<GroupEntity>.from(state.sessionGroups)
        ..add(newGroup);

      emit(
        state.copyWith(
          status: ScannerStatus.ready,
          currentGroup: newGroup,
          sessionGroups: updatedSessionGroups,
          currentGroupImageCount: 0,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: ScannerStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void finishSession() {
    emit(state.copyWith(status: ScannerStatus.sessionFinished));
  }
}
