import 'dart:convert';

import '../../domain/entities/sub_reddit_child.dart';
import 'sub_reddit_child_data.dart';

class SubRedditChildModel extends SubRedditChild {
  final SubRedditChildData data;
  SubRedditChildModel({
    this.data,
  });

  SubRedditChildModel copyWith({
    SubRedditChildData data,
  }) {
    return SubRedditChildModel(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data?.toMap(),
    };
  }

  factory SubRedditChildModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SubRedditChildModel(
      data: SubRedditChildData.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubRedditChildModel.fromJson(String source) =>
      SubRedditChildModel.fromMap(json.decode(source));

  @override
  String toString() => 'Data(data: $data)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SubRedditChildModel && o.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}
