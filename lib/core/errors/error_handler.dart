import 'package:dio/dio.dart';
import '../constant/app_constants.dart';
import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleDioError(error);
    } else {
      failure = DataSource.unKnown.getFailure();
    }
  }

  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.connectionTimeout.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioExceptionType.badCertificate:
        return DataSource.badCertificate.getFailure();
      case DioExceptionType.badResponse:
        if (error.response != null &&
            error.response?.statusCode != null &&
            error.response?.statusMessage != null) {
          return ApiFailure(
            message: error.response?.data['message'] ?? AppConstants.serverErrorMessage,
          );
        } else {
          return DataSource.unKnown.getFailure();
        }
      case DioExceptionType.cancel:
        return DataSource.cancel.getFailure();
      case DioExceptionType.connectionError:
        return DataSource.connectionError.getFailure();
      case DioExceptionType.unknown:
        return DataSource.unKnown.getFailure();
      case DioExceptionType.transformTimeout:
        return DataSource.unKnown.getFailure();
    }
  }
}

enum DataSource {
  connectionTimeout,
  receiveTimeout,
  sendTimeout,
  badCertificate,
  connectionError,
  cancel,
  cacheError,
  noInternetConnection,
  unKnown,
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.connectionTimeout:
        return ServiceFailure(message: AppConstants.timeoutErrorMessage);
      case DataSource.cancel:
        return ServiceFailure(message: AppConstants.requestCancelledMessage);
      case DataSource.receiveTimeout:
        return ServiceFailure(message: AppConstants.timeoutErrorMessage);
      case DataSource.sendTimeout:
        return ServiceFailure(message: AppConstants.timeoutErrorMessage);
      case DataSource.cacheError:
        return ServiceFailure(message: AppConstants.cacheErrorMessage);
      case DataSource.noInternetConnection:
        return NoInternetFailure(message: AppConstants.noInternetMessage);
      case DataSource.unKnown:
        return ServiceFailure(message: AppConstants.unknownErrorMessage);
      case DataSource.badCertificate:
        return ServiceFailure(message: AppConstants.badCertificateMessage);
      case DataSource.connectionError:
        return ApiFailure(message: AppConstants.networkErrorMessage);
    }
  }
}
