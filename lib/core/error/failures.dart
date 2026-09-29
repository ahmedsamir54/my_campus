import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Server failure occurred', super.statusCode});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Local cache failure occurred'});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'Network connection issue'});
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message});
}
