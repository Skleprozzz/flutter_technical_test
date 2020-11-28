import 'package:dartz/dartz.dart';

import 'package:flutter_technical_test/features/sub_reddit/data/models/sub_reddit_model.dart';
import 'package:flutter_technical_test/features/sub_reddit/domain/repositories/sub_reddit_repository.dart';
import 'package:flutter_technical_test/features/sub_reddit/domain/usecases/get_sub_reddit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixtures_reader.dart';

class MockSubRedditRepository extends Mock implements SubRedditRepository {}

main() {
  GetSubReddit usecase;

  MockSubRedditRepository mockSubRedditRepository;

  setUp(() {
    mockSubRedditRepository = MockSubRedditRepository();

    usecase = GetSubReddit(mockSubRedditRepository);
  });

  final SubRedditModel tsubRedditModel =
      SubRedditModel.fromJson(fixture('reddit_posts.json'));
  test('should return subreddit from repo', () async {
    // arrange
    when(mockSubRedditRepository.getSubReddit())
        .thenAnswer((_) async => Right(tsubRedditModel));
    // act
    final result = await usecase();
    // assert
    expect(result, Right(tsubRedditModel));
    verify(mockSubRedditRepository.getSubReddit());
    verifyNoMoreInteractions(mockSubRedditRepository);
  });
}
