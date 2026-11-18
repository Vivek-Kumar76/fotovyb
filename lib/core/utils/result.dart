import 'package:equatable/equatable.dart';

sealed class Result<S, F> extends Equatable {
  const Result();

  bool get isSuccess => this is Success<S, F>;
  bool get isFailure => this is FailureResult<S, F>;

  S? get dataOrNull => switch (this) {
        Success(:final data) => data,
        FailureResult() => null,
      };

  F? get failureOrNull => switch (this) {
        Success() => null,
        FailureResult(:final failure) => failure,
      };

  R fold<R>(R Function(S data, bool isFromCache) onSuccess, R Function(F failure) onFailure) {
    return switch (this) {
      Success(:final data, :final isFromCache) => onSuccess(data, isFromCache),
      FailureResult(:final failure) => onFailure(failure),
    };
  }
}

final class Success<S, F> extends Result<S, F> {
  final S data;
  final bool isFromCache;

  const Success(this.data, {this.isFromCache = false});

  @override
  List<Object?> get props => [data, isFromCache];
}

final class FailureResult<S, F> extends Result<S, F> {
  final F failure;

  const FailureResult(this.failure);

  @override
  List<Object?> get props => [failure];
}