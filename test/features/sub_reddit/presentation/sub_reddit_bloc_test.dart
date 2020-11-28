import 'package:dartz/dartz.dart';
import 'package:flutter_technical_test/core/errors/failures.dart';
import 'package:flutter_technical_test/features/sub_reddit/data/models/sub_reddit_child_data.dart';
import 'package:flutter_technical_test/features/sub_reddit/data/models/sub_reddit_child_model.dart';
import 'package:flutter_technical_test/features/sub_reddit/data/models/sub_reddit_model.dart';
import 'package:flutter_technical_test/features/sub_reddit/domain/usecases/get_sub_reddit.dart';
import 'package:flutter_technical_test/features/sub_reddit/presentation/bloc/sub_reddit_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetSubReddit extends Mock implements GetSubReddit {}

void main() {
  SubRedditBloc bloc;
  MockGetSubReddit mockGetSubReddit;

  setUp(() {
    mockGetSubReddit = MockGetSubReddit();

    bloc = SubRedditBloc(getSubReddit: mockGetSubReddit);
  });

  test('initial state should be Loading', () {
    expect(bloc.initialState, equals(Loading()));
  });

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

    test('should get data from the concrete use case', () async {
      when(mockGetSubReddit()).thenAnswer((_) async => Right(tsubRedditModel));

      bloc.add(GetSubRedditPosts());
      await untilCalled(mockGetSubReddit());
      verify(mockGetSubReddit());
    });

    test(
      'should emit [Loading, Loaded] when data is gotten suucessfully',
      () async {
        when(mockGetSubReddit())
            .thenAnswer((_) async => Right(tsubRedditModel));

        final expected = [
          Loading(),
          Loaded(subRedditModel: tsubRedditModel),
        ];
        expectLater(bloc, emitsInOrder(expected));

        bloc.add(GetSubRedditPosts());
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        when(mockGetSubReddit()).thenAnswer((_) async => Left(ServerFailure()));

        final expected = [
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        bloc.add(GetSubRedditPosts());
      },
    );

    test(
      'should emit [Loading, Error] with a proper message from the error when getting data fails',
      () async {
        when(mockGetSubReddit()).thenAnswer((_) async => Left(CacheFailure()));
        final expected = [
          Loading(),
          Error(message: CACHE_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        bloc.add(GetSubRedditPosts());
      },
    );
  });
}
