class AppException implements Exception {
  AppException(this.message);

  final String message;

  @override
  String toString() => message;
}

class UnauthorizedException extends AppException {
  UnauthorizedException() : super('Sesija je istekla. Prijavite se ponovno.');
}