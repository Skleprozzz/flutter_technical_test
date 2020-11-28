import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../features/sub_reddit/domain/entities/sub_reddit.dart';
import 'errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, SubReddit>> call();
}

class NoParams extends Equatable {
  List<Object> get props => [];
}
