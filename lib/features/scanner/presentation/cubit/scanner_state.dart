import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/group_entity.dart';

part 'scanner_state.freezed.dart';

enum ScannerStatus {
  initial,
  loading,
  ready,
  capturing,
  sessionFinished,
  error,
}

@freezed
class ScannerState with _$ScannerState {
  const factory ScannerState({
    @Default(ScannerStatus.initial) ScannerStatus status,
    GroupEntity? currentGroup,
    @Default([]) List<GroupEntity> sessionGroups,
    @Default(0) int currentGroupImageCount,
    String? errorMessage,
  }) = _ScannerState;
}
