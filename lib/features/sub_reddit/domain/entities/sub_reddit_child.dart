import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'sub_reddit_data.dart';

class SubRedditChild extends Equatable {
  final SubRedditData data;

  SubRedditChild({@required this.data});
  @override
  List<Object> get props => [data];
}
