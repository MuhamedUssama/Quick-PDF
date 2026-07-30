import 'package:hive_ce/hive.dart';

part 'image_model.g.dart';

@HiveType(typeId: 0)
class ImageModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String imagePath;

  @HiveField(2)
  final String? extractedText;

  @HiveField(3)
  final DateTime timestamp;

  ImageModel({
    required this.id,
    required this.imagePath,
    this.extractedText,
    required this.timestamp,
  });

  ImageModel copyWith({
    String? id,
    String? imagePath,
    String? extractedText,
    DateTime? timestamp,
  }) {
    return ImageModel(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      extractedText: extractedText ?? this.extractedText,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
