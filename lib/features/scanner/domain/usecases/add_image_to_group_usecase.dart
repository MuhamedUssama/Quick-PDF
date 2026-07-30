import 'package:injectable/injectable.dart';

import '../entities/group_entity.dart';
import '../repositories/scanner_repository.dart';

@injectable
class AddImageToGroupUseCase {
  final ScannerRepository _repository;

  const AddImageToGroupUseCase(this._repository);

  Future<GroupEntity> call({
    required String groupId,
    required String imagePath,
  }) {
    return _repository.addImageToGroup(
      groupId: groupId,
      imagePath: imagePath,
    );
  }
}
