import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/sub_reddit_model.dart';

abstract class SubRedditLocalDataSource {
  Future<SubRedditModel> getLastSubReddit();
  Future<void> cacheSubReddit(SubRedditModel subRedditModel);
}

const CACHED_SUB_REDDIT = 'CACHED_SUB_REDDIT';

class SubRedditLocalDataSourceIml implements SubRedditLocalDataSource {
  final SharedPreferences sharedPreferences;

  SubRedditLocalDataSourceIml({
    @required this.sharedPreferences,
  });

  @override
  Future<SubRedditModel> getLastSubReddit() {
    final jsonString = sharedPreferences.getString(CACHED_SUB_REDDIT);
    if (jsonString != null) {
      return Future.value(SubRedditModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheSubReddit(SubRedditModel subRedditToCache) {
    return sharedPreferences.setString(
        CACHED_SUB_REDDIT, json.encode(subRedditToCache));
  }
}
