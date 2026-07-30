import 'package:injectable/injectable.dart';

import '../repositories/pdf_generator_repository.dart';

@injectable
class ExtractArabicTextUseCase {
  final PdfGeneratorRepository _repository;

  const ExtractArabicTextUseCase(this._repository);

  Future<String> call({required String imagePath}) {
    return _repository.extractArabicTextFromImage(imagePath: imagePath);
  }
}
