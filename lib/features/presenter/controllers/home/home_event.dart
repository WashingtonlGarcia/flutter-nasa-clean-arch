part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {}

class HomeGetSpaceMediaFromDateEvent extends HomeEvent {
  final DateTime dateTime;

  HomeGetSpaceMediaFromDateEvent({required this.dateTime});

  @override
  List<Object?> get props => [dateTime];
}
