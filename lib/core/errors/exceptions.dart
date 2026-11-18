class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => 'AppException(message: $message, statusCode: $statusCode)';
}

class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.statusCode,
  });
}

class NetworkException extends AppException {
  const NetworkException({
    super.message = "No internet connection or network timed out.",
    super.statusCode,
  });
}

class CacheException extends AppException {
  const CacheException({
    super.message = "Failed to read or write local storage cache.",
    super.statusCode,
  });
}

class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = "Session expired or user unauthenticated.",
    super.statusCode = 401,
  });
}