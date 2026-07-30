import '../../domain/entities/group_entity.dart';
import '../../domain/entities/image_entity.dart';
import '../models/group_model.dart';
import '../models/image_model.dart';

extension ImageModelMapper on ImageModel {
  ImageEntity toEntity() {
    return ImageEntity(
      id: id,
      imagePath: imagePath,
      extractedText: extractedText,
      timestamp: timestamp,
    );
  }
}

extension ImageEntityMapper on ImageEntity {
  ImageModel toModel() {
    return ImageModel(
      id: id,
      imagePath: imagePath,
      extractedText: extractedText,
      timestamp: timestamp,
    );
  }
}

extension GroupModelMapper on GroupModel {
  GroupEntity toEntity() {
    return GroupEntity(
      id: id,
      groupName: groupName,
      images: images.map((img) => img.toEntity()).toList(),
      createdAt: createdAt,
    );
  }
}

extension GroupEntityMapper on GroupEntity {
  GroupModel toModel() {
    return GroupModel(
      id: id,
      groupName: groupName,
      images: images.map((img) => img.toModel()).toList(),
      createdAt: createdAt,
    );
  }
}
