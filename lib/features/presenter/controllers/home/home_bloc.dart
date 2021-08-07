import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failure.dart';
import '../../../domain/entities/space_media_entity.dart';
import '../../../domain/usecases/get_space_media_from_date_use_case.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetSpaceMediaFromDateUsecase usecase;

  HomeBloc({required this.usecase}) : super(HomeInitialState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeGetSpaceMediaFromDateEvent) {
      yield* mapGetSpaceMediaFromDateEventToState(event: event);
    }
  }

  Stream<HomeState> mapGetSpaceMediaFromDateEventToState({required HomeGetSpaceMediaFromDateEvent event}) async* {
    yield HomeLoadingState();
    final result = await usecase(params: Params(date: event.dateTime));
    yield result.fold((l) => HomeFailureState(failure: l), (r) => HomeSuccessState(entity: r));
  }
}
