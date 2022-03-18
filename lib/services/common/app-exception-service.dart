class AppException implements Exception {
  final String? _message;
  // final _prefix;

  AppException([this._message]);

  String toString() {
    return "$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String?message])
      : super(message);
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message);
}

class UnprocessableException extends AppException {
  UnprocessableException([message]) : super(message);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message);
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message);
}