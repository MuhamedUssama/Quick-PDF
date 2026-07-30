class ImageEntity {
  final String id;
  final String imagePath;
  final String? extractedText;
  final DateTime timestamp;

  const ImageEntity({
    required this.id,
    required this.imagePath,
    this.extractedText,
    required this.timestamp,
  });

  ImageEntity copyWith({
    String? id,
    String? imagePath,
    String? extractedText,
    DateTime? timestamp,
  }) {
    return ImageEntity(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      extractedText: extractedText ?? this.extractedText,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
