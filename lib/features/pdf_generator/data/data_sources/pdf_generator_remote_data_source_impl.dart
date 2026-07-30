import 'dart:io';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/app_constants.dart';
import 'pdf_generator_remote_data_source.dart';

@Injectable(as: PdfGeneratorRemoteDataSource)
class PdfGeneratorRemoteDataSourceImpl implements PdfGeneratorRemoteDataSource {
  const PdfGeneratorRemoteDataSourceImpl();

  @override
  Future<String> extractArabicTextFromImage(String imagePath) async {
    final file = File(imagePath);
    if (!await file.exists()) {
      throw FileSystemException('Image file not found at path', imagePath);
    }

    final bytes = await file.readAsBytes();
    final mimeType = imagePath.toLowerCase().endsWith('.png')
        ? AppConstants.mimeTypePng
        : AppConstants.mimeTypeJpeg;

    final model = FirebaseAI.googleAI().generativeModel(model: AppConstants.geminiModel);

    final content = Content.multi([
      TextPart(AppConstants.arabicOcrPrompt),
      InlineDataPart(mimeType, bytes),
    ]);

    final response = await model.generateContent([content]);
    final extractedText = response.text?.trim() ?? '';

    if (extractedText.isEmpty) {
      throw const FormatException('No text could be extracted from the image.');
    }

    return extractedText;
  }
}
