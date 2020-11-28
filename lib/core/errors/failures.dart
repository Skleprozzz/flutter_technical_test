import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  List<dynamic> properties = [];
  Failure({this.properties});

  List<Object> get props => properties;
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
