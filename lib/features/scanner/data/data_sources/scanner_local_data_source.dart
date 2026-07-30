import '../models/group_model.dart';

abstract interface class ScannerLocalDataSource {
  Future<void> initLocalStorage();
  Future<GroupModel> createGroup(String groupName);
  Future<GroupModel> addImageToGroup(String groupId, String imagePath);
  Future<List<GroupModel>> getAllGroups();
  Future<GroupModel?> getGroupById(String groupId);
  Future<void> updateImageExtractedText(String groupId, String imageId, String extractedText);
  Future<void> deleteGroup(String groupId);
  Future<void> deleteImageFromGroup(String groupId, String imageId);
  Future<void> clearCache();
}
