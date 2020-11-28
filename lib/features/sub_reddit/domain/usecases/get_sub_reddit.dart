import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases.dart';
import '../entities/sub_reddit.dart';
import '../repositories/sub_reddit_repository.dart';

class GetSubReddit implements UseCase<SubReddit, NoParams> {
  final SubRedditRepository repository;

  GetSubReddit(this.repository);
  @override
  Future<Either<Failure, SubReddit>> call() async {
    return await repository.getSubReddit();
  }
}
