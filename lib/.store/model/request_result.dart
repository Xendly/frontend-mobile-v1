class RequestResult {
  final bool status;
  final String? message;
  final List<String>? messages;
  final dynamic data;

  RequestResult(
    this.status,
    this.message, {
    this.messages,
    this.data,
  });
}
