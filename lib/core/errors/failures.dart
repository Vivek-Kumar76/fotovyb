import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({
    required this.message,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, statusCode];
}

final class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.statusCode,
  });
}

final class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = "Please check your network connection and try again.",
    super.statusCode,
  });
}

final class CacheFailure extends Failure {
  const CacheFailure({
    super.message = "Could not load saved offline data.",
    super.statusCode,
  });
}

final class AuthFailure extends Failure {
  const AuthFailure({
    super.message = "You are not authorized to view this content.",
    super.statusCode = 401,
  });
}