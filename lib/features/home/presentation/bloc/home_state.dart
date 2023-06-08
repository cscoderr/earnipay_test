part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeSuccess extends HomeState {
  const HomeSuccess();
}

final class HomeFailure extends HomeState {
  const HomeFailure({required this.message});
  final String message;

  @override
  List<Object?> get props => [];
}
