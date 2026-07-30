import '../entities/group_entity.dart';

abstract interface class ScannerRepository {
  Future<void> initLocalStorage();
  Future<GroupEntity> createGroup({required String groupName});
  Future<GroupEntity> addImageToGroup({
    required String groupId,
    required String imagePath,
  });
  Future<List<GroupEntity>> getAllGroups();
  Future<GroupEntity?> getGroupById({required String groupId});
  Future<void> updateImageExtractedText({
    required String groupId,
    required String imageId,
    required String extractedText,
  });
  Future<void> deleteGroup({required String groupId});
  Future<void> deleteImageFromGroup({
    required String groupId,
    required String imageId,
  });
  Future<void> clearCache();
}
