part of 'photo_cubit.dart';

enum PhotoStatus { initial, loading, success, failure }

final class PhotoState extends Equatable {
  const PhotoState({
    this.status = PhotoStatus.initial,
    this.photos = const <Photo>[],
    this.errorMessage = '',
    this.hasReachedMax = false,
  });

  PhotoState copyWith({
    PhotoStatus? status,
    List<Photo>? photos,
    String? errorMessage,
    bool? hasReachedMax,
  }) {
    return PhotoState(
      status: status ?? this.status,
      photos: photos ?? this.photos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  final PhotoStatus status;
  final List<Photo> photos;
  final String errorMessage;
  final bool hasReachedMax;

  @override
  List<Object?> get props => [status, photos, errorMessage, hasReachedMax];
}

final class PhotoInitial extends PhotoState {
  const PhotoInitial();
}
