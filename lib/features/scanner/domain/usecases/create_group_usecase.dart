import 'package:injectable/injectable.dart';

import '../entities/group_entity.dart';
import '../repositories/scanner_repository.dart';

@injectable
class CreateGroupUseCase {
  final ScannerRepository _repository;

  const CreateGroupUseCase(this._repository);

  Future<GroupEntity> call({required String groupName}) {
    return _repository.createGroup(groupName: groupName);
  }
}
