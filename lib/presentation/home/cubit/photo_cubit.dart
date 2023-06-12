import 'package:bloc/bloc.dart';
import 'package:earnipay_test/core/core.dart';
import 'package:earnipay_test/domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  PhotoCubit({required GetPhotoUsecase getPhotoUsecase})
      : _getPhotoUsecase = getPhotoUsecase,
        super(const PhotoInitial());

  final GetPhotoUsecase _getPhotoUsecase;

  Future<void> getPhotos({int? page}) async {
    try {
      final response = await _getPhotoUsecase.call(page: page);
      final hasReachedMax = response.length < AppConstants.photosLimit;
      final data = <Photo>[...state.photos, ...response];
      emit(
        state.copyWith(
          status: PhotoStatus.success,
          photos: data,
          hasReachedMax: hasReachedMax,
        ),
      );
    } catch (e) {
      print(e);
      emit(state.copyWith(
          status: PhotoStatus.failure, errorMessage: 'Something went wrong'));
    }
  }
}
