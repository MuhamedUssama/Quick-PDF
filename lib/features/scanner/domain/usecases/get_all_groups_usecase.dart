import 'package:injectable/injectable.dart';

import '../entities/group_entity.dart';
import '../repositories/scanner_repository.dart';

@injectable
class GetAllGroupsUseCase {
  final ScannerRepository _repository;

  const GetAllGroupsUseCase(this._repository);

  Future<List<GroupEntity>> call() {
    return _repository.getAllGroups();
  }
}
