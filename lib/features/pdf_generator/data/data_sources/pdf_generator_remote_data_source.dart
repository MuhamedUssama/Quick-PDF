abstract interface class PdfGeneratorRemoteDataSource {
  Future<String> extractArabicTextFromImage(String imagePath);
}
