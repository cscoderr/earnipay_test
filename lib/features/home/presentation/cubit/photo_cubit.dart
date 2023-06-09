import 'package:bloc/bloc.dart';
import 'package:earnipay_test/features/home/home.dart';
import 'package:equatable/equatable.dart';

part 'photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  PhotoCubit({required GetPhotoUsecase getPhotoUsecase})
      : _getPhotoUsecase = getPhotoUsecase,
        super(const PhotoInitial());

  final GetPhotoUsecase _getPhotoUsecase;

  Future<void> getPhotos() async {
    // try {
    emit(const PhotoLoading());
    final response = await _getPhotoUsecase.call();
    emit(PhotoSuccess(response));
    // } catch (e) {
    //   print(e);
    //   emit(const PhotoFailure('Something went wrong'));
    // }
  }
}
