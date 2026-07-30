class OcrResultEntity {
  final String imagePath;
  final String extractedText;

  const OcrResultEntity({
    required this.imagePath,
    required this.extractedText,
  });
}
