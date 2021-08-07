part of 'home_bloc.dart';

abstract class HomeState extends Equatable {}

class HomeInitialState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeSuccessState extends HomeState {
  final SpaceMediaEntity entity;

  HomeSuccessState({required this.entity});

  @override
  List<Object?> get props => [entity];
}

class HomeFailureState extends HomeState {
  final Failure failure;

  HomeFailureState({required this.failure});

  @override
  List<Object?> get props =>[failure];
}
