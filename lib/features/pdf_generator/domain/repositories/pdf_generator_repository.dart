abstract interface class PdfGeneratorRepository {
  Future<String> extractArabicTextFromImage({
    required String imagePath,
  });
}
