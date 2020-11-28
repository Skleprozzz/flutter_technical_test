part of 'sub_reddit_bloc.dart';

abstract class SubRedditEvent extends Equatable {
  const SubRedditEvent();

  @override
  List<Object> get props => [];
}

class GetSubRedditPosts extends SubRedditEvent {
  GetSubRedditPosts();
}
