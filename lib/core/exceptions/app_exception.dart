import 'package:equatable/equatable.dart';

class AppException extends Equatable implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() {
    return 'AppException{message: $message}';
  }

  @override
  List<Object?> get props => [message];
}
