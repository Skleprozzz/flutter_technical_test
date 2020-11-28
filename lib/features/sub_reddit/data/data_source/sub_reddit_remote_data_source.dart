import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/sub_reddit_model.dart';

abstract class SubRedditRemoteDataSource {
  Future<SubRedditModel> getSubReddit();
}

const SUB_REDDIT_CHANEL_NAME = 'FlutterDev';

class SubRedditRemoteDataSourceIml implements SubRedditRemoteDataSource {
  final http.Client client;

  SubRedditRemoteDataSourceIml({@required this.client});

  Future<SubRedditModel> _getSubRedditFromUrl(String url) async {
    final response =
        await client.get(url, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return SubRedditModel.fromJson(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SubRedditModel> getSubReddit() => _getSubRedditFromUrl(
      'https://www.reddit.com/r/$SUB_REDDIT_CHANEL_NAME.json');
}
