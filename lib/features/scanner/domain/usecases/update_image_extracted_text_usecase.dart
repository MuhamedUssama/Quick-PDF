import 'package:injectable/injectable.dart';

import '../repositories/scanner_repository.dart';

@injectable
class UpdateImageExtractedTextUseCase {
  final ScannerRepository _repository;

  const UpdateImageExtractedTextUseCase(this._repository);

  Future<void> call({
    required String groupId,
    required String imageId,
    required String extractedText,
  }) {
    return _repository.updateImageExtractedText(
      groupId: groupId,
      imageId: imageId,
      extractedText: extractedText,
    );
  }
}
