import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'sub_reddit_child.dart';

class SubReddit extends Equatable {
  final List<SubRedditChild> children;
  SubReddit({
    @required this.children,
  });

  @override
  List<Object> get props => [children];
}
