import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../usecase/errors/failures.dart';

//caso de uso. Contrato de como tem que ser feito quando essa classe for chamada
abstract class Usecase<Output, Input> {
  Future<Either<Failure, Output>> call(Input params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
