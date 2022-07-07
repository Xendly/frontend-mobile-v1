class HttpResult<T> {
  final int? statusCode;
  final bool status;
  final dynamic message;
  final T? data;
  HttpResult(this.status, this.message, {this.statusCode = 200, this.data});

  HttpResult.fromMap(Map<String, dynamic> response)
      : statusCode = response['code'],
        message = response['message'],
        status = response['status'],
        data = response['data'];
}
