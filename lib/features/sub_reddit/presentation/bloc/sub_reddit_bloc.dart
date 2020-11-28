import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/sub_reddit_model.dart';
import '../../domain/entities/sub_reddit.dart';
import '../../domain/usecases/get_sub_reddit.dart';

part 'sub_reddit_event.dart';
part 'sub_reddit_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class SubRedditBloc extends Bloc<SubRedditEvent, SubRedditState> {
  final GetSubReddit getSubReddit;

  SubRedditBloc({@required GetSubReddit getSubReddit})
      : assert(getSubReddit != null),
        getSubReddit = getSubReddit;

  @override
  SubRedditState get initialState => Loading();

  @override
  Stream<SubRedditState> mapEventToState(
    SubRedditEvent event,
  ) async* {
    if (event is GetSubRedditPosts) {
      final failureOrSubReddit = await getSubReddit();
      yield* _eitherLoadedOfErrorState(failureOrSubReddit);
    }
  }

  Stream<SubRedditState> _eitherLoadedOfErrorState(
      Either<Failure, SubReddit> failureOrSubReddit) async* {
    yield failureOrSubReddit.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (subReddit) => Loaded(subRedditModel: subReddit));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unxpected error';
    }
  }
}
