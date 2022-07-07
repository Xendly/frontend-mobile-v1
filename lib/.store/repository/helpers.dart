import 'package:xendly_mobile/model/http_result.dart';
import 'package:xendly_mobile/model/request_result.dart';

RequestResult parseHttpError(HttpResult httpResult) {
  if (httpResult.message is String) {
    return RequestResult(
      httpResult.status,
      httpResult.message,
      data: httpResult.data,
    );
  } else if (httpResult.message is Map) {
    final mappedMessages = httpResult.message as Map;
    List<String> messages = [];
    mappedMessages.forEach((key, value) {
      if (value is String) {
        messages.add(value);
      } else if (value is List) {
        messages.add(value.first);
      }
    });
    return RequestResult(
      httpResult.status,
      null,
      messages: messages,
      data: httpResult.data,
    );
  } else {
    return RequestResult(
      false,
      "An unknown error occured",
      data: httpResult.data,
    );
  }
}
