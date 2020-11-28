import 'dart:convert';

import 'package:meta/meta.dart';

import '../../domain/entities/sub_reddit_data.dart';

class SubRedditChildData extends SubRedditData {
  SubRedditChildData({
    @required String subreddit,
    @required String selftext,
    @required String title,
    @required int score,
    @required double created,
    @required String subreddit_id,
    @required String permalink,
    @required String id,
    @required String author,
    @required int num_comments,
    @required String url,
  }) : super(
            subreddit: subreddit,
            author: author,
            created: created,
            id: id,
            num_comments: num_comments,
            permalink: permalink,
            score: score,
            selftext: selftext,
            subreddit_id: subreddit_id,
            title: title,
            url: url);

  SubRedditChildData copyWith({
    String subreddit,
    String selftext,
    String title,
    int score,
    int created,
    String subreddit_id,
    String permalink,
    String id,
    String author,
    int num_comments,
    String url,
  }) {
    return SubRedditChildData(
      subreddit: subreddit ?? this.subreddit,
      selftext: selftext ?? this.selftext,
      title: title ?? this.title,
      score: score ?? this.score,
      created: created ?? this.created,
      subreddit_id: subreddit_id ?? this.subreddit_id,
      permalink: permalink ?? this.permalink,
      id: id ?? this.id,
      author: author ?? this.author,
      num_comments: num_comments ?? this.num_comments,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subreddit': subreddit,
      'selftext': selftext,
      'title': title,
      'score': score,
      'created': created,
      'subreddit_id': subreddit_id,
      'permalink': permalink,
      'id': id,
      'author': author,
      'num_comments': num_comments,
      'url': url,
    };
  }

  factory SubRedditChildData.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SubRedditChildData(
      subreddit: map['subreddit'],
      selftext: map['selftext'],
      title: map['title'],
      score: map['score']?.toInt(),
      created: map['created']?.toDouble(),
      subreddit_id: map['subreddit_id'],
      permalink: map['permalink'],
      id: map['id'],
      author: map['author'],
      num_comments: map['num_comments']?.toInt(),
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SubRedditChildData.fromJson(String source) =>
      SubRedditChildData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubRedditChildData(subreddit: $subreddit, selftext: $selftext, title: $title, score: $score, created: $created, subreddit_id: $subreddit_id, permalink: $permalink, id: $id, author: $author, num_comments: $num_comments, url: $url)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SubRedditChildData &&
        o.subreddit == subreddit &&
        o.selftext == selftext &&
        o.title == title &&
        o.score == score &&
        o.created == created &&
        o.subreddit_id == subreddit_id &&
        o.permalink == permalink &&
        o.id == id &&
        o.author == author &&
        o.num_comments == num_comments &&
        o.url == url;
  }

  @override
  int get hashCode {
    return subreddit.hashCode ^
        selftext.hashCode ^
        title.hashCode ^
        score.hashCode ^
        created.hashCode ^
        subreddit_id.hashCode ^
        permalink.hashCode ^
        id.hashCode ^
        author.hashCode ^
        num_comments.hashCode ^
        url.hashCode;
  }
}
