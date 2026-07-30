import 'dart:io';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:hive_ce/hive.dart';

import 'failures.dart';

class ErrorHandler {
  static Failure handle(dynamic error) {
    if (error is Failure) {
      return error;
    }

    if (error is FirebaseAIException) {
      return OcrFailure(
        'AI service error: ${error.message}',
        'FIREBASE_AI_ERROR',
      );
    }

    if (error is QuotaExceeded) {
      return const ServerFailure(
        'Usage limit exceeded. Please try again later.',
        'QUOTA_EXCEEDED',
      );
    }

    if (error is InvalidApiKey) {
      return const ServerFailure(
        'Invalid API key. Please check your configuration.',
        'INVALID_API_KEY',
      );
    }

    if (error is ServerException) {
      return const ServerFailure(
        'AI server is currently unreachable. Please try again later.',
        'SERVER_ERROR',
      );
    }

    if (error is HiveError) {
      return DatabaseFailure(
        'Local database error: ${error.message}',
        'HIVE_ERROR',
      );
    }

    if (error is FileSystemException) {
      return const FileNotFoundFailure(
        'Unable to access the image file in local storage.',
        'FILE_SYSTEM_ERROR',
      );
    }

    if (error is SocketException) {
      return const NetworkFailure();
    }

    if (error is FormatException) {
      return const OcrFailure(
        'Unsupported file format or corrupt content.',
        'FORMAT_ERROR',
      );
    }

    return UnknownFailure(
      'An unexpected error occurred: ${error.toString()}',
      'UNKNOWN_ERROR',
    );
  }
}
