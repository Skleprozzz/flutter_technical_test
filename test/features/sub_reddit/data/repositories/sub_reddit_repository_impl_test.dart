import 'package:dartz/dartz.dart';
import 'package:flutter_technical_test/core/errors/exceptions.dart';
import 'package:flutter_technical_test/core/errors/failures.dart';
import 'package:flutter_technical_test/core/network/network_info.dart';
import 'package:flutter_technical_test/features/sub_reddit/data/data_source/sub_reddit_local_data_source.dart';
import 'package:flutter_technical_test/features/sub_reddit/data/data_source/sub_reddit_remote_data_source.dart';
import 'package:flutter_technical_test/features/sub_reddit/data/models/sub_reddit_child_data.dart';
import 'package:flutter_technical_test/features/sub_reddit/data/models/sub_reddit_child_model.dart';
import 'package:flutter_technical_test/features/sub_reddit/data/models/sub_reddit_model.dart';
import 'package:flutter_technical_test/features/sub_reddit/data/repositories/sub_reddit_repository.dart';
import 'package:flutter_technical_test/features/sub_reddit/domain/entities/sub_reddit.dart';
import 'package:flutter_technical_test/features/sub_reddit/domain/repositories/sub_reddit_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements SubRedditRemoteDataSource {}

class MockLocalDataSource extends Mock implements SubRedditLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  SubRedditRepository repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = SubRedditRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getSubReddit', () {
    final SubRedditModel tsubRedditModel = SubRedditModel(children: [
      SubRedditChildModel(
          data: SubRedditChildData(
              subreddit: "FlutterDev",
              selftext:
                  "Hello everyone! \ud83d\udc4b\n\nI made a free, three-part Dart and Flutter series directed at beginner developers in which through the course you'll build a game while learning the foundations of Dart and Flutter.\n\nI've put a lot of effort into making this series and other content (the demo app, charts, etc.) and I'd appreciate your feedback on it.\n\nFirst part - Dart: [https://blog.risingstack.com/learn-dart-language-beginner-tutorial/](https://blog.risingstack.com/learn-dart-language-beginner-tutorial/)  \nSecond part - Flutter: [https://blog.risingstack.com/flutter-crash-course-javascript/](https://blog.risingstack.com/flutter-crash-course-javascript/)  \nThird part - building a game: [https://blog.risingstack.com/case-study-dart-flutter-mobile-game/](https://blog.risingstack.com/case-study-dart-flutter-mobile-game/)\n\nAll the bests,  \nDaniel \u2764\ufe0f",
              title: "Learn Dart and Flutter from the basics: free series",
              score: 85,
              created: 1606447048.0,
              subreddit_id: "t5_2x3q8",
              permalink:
                  "/r/FlutterDev/comments/k1zabz/learn_flutter_like_a_pro_2021_edition_absolutely/",
              id: "k1lh99",
              author: "dandesz198",
              num_comments: 3,
              url:
                  "https://www.reddit.com/r/FlutterDev/comments/k1lh99/learn_dart_and_flutter_from_the_basics_free_series/"))
    ]);

    final SubReddit tsubReddit = tsubRedditModel;
    test('should check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getSubReddit();
      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test(
          'should return remote data when the call to remote data source is successfull',
          () async {
        when(mockRemoteDataSource.getSubReddit())
            .thenAnswer((_) async => tsubRedditModel);

        final result = await repository.getSubReddit();

        verify(mockRemoteDataSource.getSubReddit());
        expect(result, equals(Right(tsubReddit)));
      });

      test(
          'should cache the data localy when the call to remote data source is successfull',
          () async {
        when(mockRemoteDataSource.getSubReddit())
            .thenAnswer((_) async => tsubRedditModel);

        await repository.getSubReddit();

        verify(mockRemoteDataSource.getSubReddit());
        verify(mockLocalDataSource.cacheSubReddit(tsubReddit));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessfull',
          () async {
        when(mockRemoteDataSource.getSubReddit()).thenThrow(ServerException());

        final result = await repository.getSubReddit();

        verify(mockRemoteDataSource.getSubReddit());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test(
          'should return last localy cached data when the cached data is present',
          () async {
        when(mockLocalDataSource.getLastSubReddit())
            .thenAnswer((_) async => tsubRedditModel);

        final result = await repository.getSubReddit();
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastSubReddit());
        expect(result, equals(Right(tsubReddit)));
      });

      test('should return CacheFailure when threre is no cached data present',
          () async {
        when(mockLocalDataSource.getLastSubReddit())
            .thenThrow(CacheException());

        final result = await repository.getSubReddit();

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastSubReddit());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
