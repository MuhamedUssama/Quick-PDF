import 'package:injectable/injectable.dart';

import '../../../../core/errors/error_handler.dart';
import '../../domain/entities/group_entity.dart';
import '../../domain/repositories/scanner_repository.dart';
import '../data_sources/scanner_local_data_source.dart';
import '../mappers/scanner_mappers.dart';

@Injectable(as: ScannerRepository)
class ScannerRepositoryImpl implements ScannerRepository {
  final ScannerLocalDataSource _localDataSource;

  const ScannerRepositoryImpl(this._localDataSource);

  @override
  Future<void> initLocalStorage() async {
    try {
      await _localDataSource.initLocalStorage();
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<GroupEntity> createGroup({required String groupName}) async {
    try {
      final model = await _localDataSource.createGroup(groupName);
      return model.toEntity();
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<GroupEntity> addImageToGroup({
    required String groupId,
    required String imagePath,
  }) async {
    try {
      final model = await _localDataSource.addImageToGroup(groupId, imagePath);
      return model.toEntity();
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<List<GroupEntity>> getAllGroups() async {
    try {
      final models = await _localDataSource.getAllGroups();
      return models.map((m) => m.toEntity()).toList();
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<GroupEntity?> getGroupById({required String groupId}) async {
    try {
      final model = await _localDataSource.getGroupById(groupId);
      return model?.toEntity();
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<void> updateImageExtractedText({
    required String groupId,
    required String imageId,
    required String extractedText,
  }) async {
    try {
      await _localDataSource.updateImageExtractedText(
        groupId,
        imageId,
        extractedText,
      );
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<void> deleteGroup({required String groupId}) async {
    try {
      await _localDataSource.deleteGroup(groupId);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<void> deleteImageFromGroup({
    required String groupId,
    required String imageId,
  }) async {
    try {
      await _localDataSource.deleteImageFromGroup(groupId, imageId);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await _localDataSource.clearCache();
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}
