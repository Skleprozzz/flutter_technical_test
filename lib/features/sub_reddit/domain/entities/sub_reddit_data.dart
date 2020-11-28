import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SubRedditData extends Equatable {
  final String subreddit;
  final String selftext;
  final String title;
  final int score;
  final double created;
  final String subreddit_id;
  final String permalink;
  final String id;
  final String author;
  final int num_comments;
  final String url;

  SubRedditData({
    @required this.subreddit,
    @required this.selftext,
    @required this.title,
    @required this.score,
    @required this.created,
    @required this.subreddit_id,
    @required this.permalink,
    @required this.id,
    @required this.author,
    @required this.num_comments,
    @required this.url,
  });

  @override
  List<Object> get props => [
        subreddit,
        selftext,
        title,
        score,
        created,
        subreddit_id,
        permalink,
        id,
        author,
        num_comments,
        url,
      ];
}
