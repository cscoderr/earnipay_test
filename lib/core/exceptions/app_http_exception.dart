import 'package:equatable/equatable.dart';

class AppHttpException extends Equatable implements Exception {
  const AppHttpException(this.message);

  final String message;

  @override
  String toString() {
    return 'AppException{message: $message}';
  }

  @override
  List<Object?> get props => [message];
}
