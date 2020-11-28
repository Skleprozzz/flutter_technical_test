import 'dart:convert';

import 'package:collection/collection.dart';

import '../../domain/entities/sub_reddit.dart';
import 'sub_reddit_child_model.dart';

class SubRedditModel extends SubReddit {
  final List<SubRedditChildModel> children;
  SubRedditModel({
    this.children,
  });

  SubRedditModel copyWith({
    List<SubRedditChildModel> data,
  }) {
    return SubRedditModel(
      children: children ?? this.children,
    );
  }

  Map<String, dynamic> toMap() {
    var data = {'children': children?.map((x) => x?.toMap())?.toList()};

    return {'data': data};
  }

  factory SubRedditModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SubRedditModel(
      children: List<SubRedditChildModel>.from(
          map['data']['children']?.map((x) => SubRedditChildModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubRedditModel.fromJson(String source) =>
      SubRedditModel.fromMap(json.decode(source));

  @override
  String toString() => 'SubRedditModel(children: $children)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return o is SubRedditModel && listEquals(o.children, children);
  }

  @override
  int get hashCode => children.hashCode;
}
