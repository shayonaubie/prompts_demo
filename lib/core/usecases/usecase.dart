import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

abstract class UseCaseWithFailure<Type, Params> {
  Future<UseCaseResult<Type>> call(Params params);
}

class UseCaseResult<T> {
  final T? data;
  final Failure? failure;
  final bool isSuccess;

  UseCaseResult._({this.data, this.failure, required this.isSuccess});

  factory UseCaseResult.success(T data) {
    return UseCaseResult._(data: data, isSuccess: true);
  }

  factory UseCaseResult.failure(Failure failure) {
    return UseCaseResult._(failure: failure, isSuccess: false);
  }
}

class NoParams {
  const NoParams();
}
