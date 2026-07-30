abstract class Failure implements Exception {
  final String message;
  final String? code;

  const Failure(this.message, [this.code]);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure([
    super.message = 'A server connection error occurred. Please try again later.',
    super.code,
  ]);
}

class OcrFailure extends Failure {
  const OcrFailure([
    super.message = 'Unable to recognize the handwritten text in this image.',
    super.code,
  ]);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure([
    super.message = 'An error occurred while saving data to the device.',
    super.code,
  ]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'No internet connection. Please check your network and try again.',
    super.code,
  ]);
}

class FileNotFoundFailure extends Failure {
  const FileNotFoundFailure([
    super.message = 'The image file was not found on the device.',
    super.code,
  ]);
}

class UnknownFailure extends Failure {
  const UnknownFailure([
    super.message = 'An unexpected error occurred. Please try again later.',
    super.code,
  ]);
}
