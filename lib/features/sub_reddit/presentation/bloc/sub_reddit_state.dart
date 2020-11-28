part of 'sub_reddit_bloc.dart';

abstract class SubRedditState extends Equatable {
  const SubRedditState();

  @override
  List<Object> get props => [];
}

class Loading extends SubRedditState {
  @override
  List<Object> get props => [];
}

class Loaded extends SubRedditState {
  final SubRedditModel subRedditModel;

  Loaded({@required this.subRedditModel});

  @override
  List<Object> get props => [subRedditModel];
}

class Error extends SubRedditState {
  String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
