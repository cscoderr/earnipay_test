part of 'photo_cubit.dart';

sealed class PhotoState extends Equatable {
  const PhotoState();
  @override
  List<Object?> get props => [];
}

final class PhotoInitial extends PhotoState {
  const PhotoInitial();
}

final class PhotoLoading extends PhotoState {
  const PhotoLoading();
}

final class PhotoSuccess extends PhotoState {
  const PhotoSuccess(this.photos);

  final List<Photo> photos;

  @override
  List<Object?> get props => [photos];
}

final class PhotoFailure extends PhotoState {
  const PhotoFailure(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
