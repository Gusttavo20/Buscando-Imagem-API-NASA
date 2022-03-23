import 'package:equatable/equatable.dart';

//retornar "falha"
abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NullParamFailure extends Failure {
  @override
  List<Object?> get props => [];
}
