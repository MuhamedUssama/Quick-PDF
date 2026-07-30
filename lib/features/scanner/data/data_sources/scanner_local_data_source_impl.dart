import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/utils/app_constants.dart';
import '../models/group_model.dart';
import '../models/image_model.dart';
import 'scanner_local_data_source.dart';

@Injectable(as: ScannerLocalDataSource)
class ScannerLocalDataSourceImpl implements ScannerLocalDataSource {
  const ScannerLocalDataSourceImpl();

  @override
  Future<void> initLocalStorage() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ImageModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupModelAdapter());
    }
    if (!Hive.isBoxOpen(AppConstants.groupsBox)) {
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      await Hive.openBox<GroupModel>(AppConstants.groupsBox);
    }
  }

  Future<Box<GroupModel>> _getBox() async {
    if (!Hive.isBoxOpen(AppConstants.groupsBox)) {
      await initLocalStorage();
    }
    return Hive.box<GroupModel>(AppConstants.groupsBox);
  }

  @override
  Future<GroupModel> createGroup(String groupName) async {
    final box = await _getBox();
    final newGroup = GroupModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      groupName: groupName,
      images: [],
      createdAt: DateTime.now(),
    );
    await box.put(newGroup.id, newGroup);
    return newGroup;
  }

  @override
  Future<GroupModel> addImageToGroup(String groupId, String imagePath) async {
    final box = await _getBox();
    final group = box.get(groupId);
    if (group == null) {
      throw Exception('Group with id $groupId not found.');
    }

    final newImage = ImageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      imagePath: imagePath,
      timestamp: DateTime.now(),
    );

    final updatedImages = List<ImageModel>.from(group.images)..add(newImage);
    final updatedGroup = group.copyWith(images: updatedImages);

    await box.put(groupId, updatedGroup);
    return updatedGroup;
  }

  @override
  Future<List<GroupModel>> getAllGroups() async {
    final box = await _getBox();
    return box.values.toList();
  }

  @override
  Future<GroupModel?> getGroupById(String groupId) async {
    final box = await _getBox();
    return box.get(groupId);
  }

  @override
  Future<void> updateImageExtractedText(String groupId, String imageId, String extractedText) async {
    final box = await _getBox();
    final group = box.get(groupId);
    if (group == null) {
      throw Exception('Group with id $groupId not found.');
    }

    final updatedImages = group.images.map((img) {
      if (img.id == imageId) {
        return img.copyWith(extractedText: extractedText);
      }
      return img;
    }).toList();

    final updatedGroup = group.copyWith(images: updatedImages);
    await box.put(groupId, updatedGroup);
  }

  @override
  Future<void> deleteGroup(String groupId) async {
    final box = await _getBox();
    await box.delete(groupId);
  }

  @override
  Future<void> deleteImageFromGroup(String groupId, String imageId) async {
    final box = await _getBox();
    final group = box.get(groupId);
    if (group == null) return;

    final updatedImages = group.images.where((img) => img.id != imageId).toList();
    final updatedGroup = group.copyWith(images: updatedImages);
    await box.put(groupId, updatedGroup);
  }

  @override
  Future<void> clearCache() async {
    final box = await _getBox();
    await box.clear();
  }
}
