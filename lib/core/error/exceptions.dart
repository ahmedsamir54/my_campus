class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException({this.message = 'Server Exception', this.statusCode});
}

class CacheException implements Exception {
  final String message;

  const CacheException({this.message = 'Cache Exception'});
}

class NetworkException implements Exception {
  final String message;

  const NetworkException({this.message = 'Network Exception'});
}
