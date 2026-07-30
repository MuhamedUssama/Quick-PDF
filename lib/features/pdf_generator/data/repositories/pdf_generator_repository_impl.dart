import 'package:injectable/injectable.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/services/network_info.dart';
import '../../domain/repositories/pdf_generator_repository.dart';
import '../data_sources/pdf_generator_remote_data_source.dart';

@Injectable(as: PdfGeneratorRepository)
class PdfGeneratorRepositoryImpl implements PdfGeneratorRepository {
  final PdfGeneratorRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  const PdfGeneratorRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  @override
  Future<String> extractArabicTextFromImage({
    required String imagePath,
  }) async {
    if (!await _networkInfo.isConnected) {
      throw ErrorHandler.handle('NO_INTERNET');
    }

    try {
      return await _remoteDataSource.extractArabicTextFromImage(imagePath);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}
