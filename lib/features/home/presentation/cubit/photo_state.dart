part of 'photo_cubit.dart';

sealed class PhotoState extends Equatable {
  const PhotoState();
  @override
  List<Object?> get props => [];
}

final class PhotoInitial extends PhotoState {
  const PhotoInitial();
}

final class PhotoSuccess extends PhotoState {
  const PhotoSuccess();
}

final class PhotoFailure extends PhotoState {
  const PhotoFailure({required this.message});
  final String message;

  @override
  List<Object?> get props => [];
}
