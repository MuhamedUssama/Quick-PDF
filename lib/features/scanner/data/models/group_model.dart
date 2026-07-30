import 'package:hive_ce/hive.dart';
import 'image_model.dart';

part 'group_model.g.dart';

@HiveType(typeId: 1)
class GroupModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String groupName;

  @HiveField(2)
  final List<ImageModel> images;

  @HiveField(3)
  final DateTime createdAt;

  GroupModel({
    required this.id,
    required this.groupName,
    required this.images,
    required this.createdAt,
  });

  GroupModel copyWith({
    String? id,
    String? groupName,
    List<ImageModel>? images,
    DateTime? createdAt,
  }) {
    return GroupModel(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
