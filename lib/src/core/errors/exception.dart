class ServerException implements Exception {
  final dynamic error;
  const ServerException(this.error);
}
