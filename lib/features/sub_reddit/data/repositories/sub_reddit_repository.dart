import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/sub_reddit.dart';
import '../../domain/repositories/sub_reddit_repository.dart';
import '../data_source/sub_reddit_local_data_source.dart';
import '../data_source/sub_reddit_remote_data_source.dart';

class SubRedditRepositoryImpl extends SubRedditRepository {
  final SubRedditRemoteDataSource remoteDataSource;
  final SubRedditLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SubRedditRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, SubReddit>> getSubReddit() async {
    return await _getSubReddit(() {
      return remoteDataSource.getSubReddit();
    });
  }

  Future<Either<Failure, SubReddit>> _getSubReddit(
      Function getSubReddit) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteSubReddit = await getSubReddit();
        localDataSource.cacheSubReddit(remoteSubReddit);
        return Right(remoteSubReddit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localSubReddit = await localDataSource.getLastSubReddit();
        return Right(localSubReddit);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
