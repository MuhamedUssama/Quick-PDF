import 'image_entity.dart';

class GroupEntity {
  final String id;
  final String groupName;
  final List<ImageEntity> images;
  final DateTime createdAt;

  const GroupEntity({
    required this.id,
    required this.groupName,
    required this.images,
    required this.createdAt,
  });

  GroupEntity copyWith({
    String? id,
    String? groupName,
    List<ImageEntity>? images,
    DateTime? createdAt,
  }) {
    return GroupEntity(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
