import 'package:injectable/injectable.dart';

import '../repositories/scanner_repository.dart';

@injectable
class DeleteGroupUseCase {
  final ScannerRepository _repository;

  const DeleteGroupUseCase(this._repository);

  Future<void> call({required String groupId}) {
    return _repository.deleteGroup(groupId: groupId);
  }
}
