import 'dart:convert';

import 'package:flutter_technical_test/features/sub_reddit/data/models/sub_reddit_child_model.dart';
import 'package:flutter_technical_test/features/sub_reddit/data/models/sub_reddit_model.dart';
import 'package:flutter_technical_test/features/sub_reddit/data/models/sub_reddit_child_data.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  final tSubRedditModelData = SubRedditChildData(
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
          "https://www.reddit.com/r/FlutterDev/comments/k1lh99/learn_dart_and_flutter_from_the_basics_free_series/");

  final tSubRedditModelData2 = SubRedditChildData(
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
      num_comments: 2,
      url:
          "https://www.reddit.com/r/FlutterDev/comments/k1lh99/learn_dart_and_flutter_from_the_basics_free_series/");

  final tSubRedditModel = SubRedditModel(children: [
    SubRedditChildModel(data: tSubRedditModelData),
    SubRedditChildModel(data: tSubRedditModelData2)
  ]);

  test('should be a subclass of SubRedditData entity', () async {
    expect(tSubRedditModelData, isA<SubRedditChildData>());
  });

  group("from Json", () {
    test("Should return a valid model", () async {
      final String jsonString = fixture('reddit_posts.json');
      final result = SubRedditModel.fromJson(jsonString);
      expect(result, tSubRedditModel);
    });
  });

  group("to Json", () {
    test("Should return a JSON string containing the proper data", () async {
      final result = json.decode(tSubRedditModel.toJson());
      final jsonString = json.decode(fixture('reddit_posts.json'));
      expect(result, jsonString);
    });
  });
}
