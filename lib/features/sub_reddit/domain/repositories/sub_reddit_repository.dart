import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/sub_reddit.dart';

abstract class SubRedditRepository {
  Future<Either<Failure, SubReddit>> getSubReddit();
}
