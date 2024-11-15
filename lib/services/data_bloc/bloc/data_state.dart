part of 'data_bloc.dart';


abstract class DataFetchState<T> extends Equatable {}

class DataFetchInitial extends DataFetchState {
  @override
  List<Object?> get props => [];
}

class DataLoading extends DataFetchState {
  @override
  List<Object?> get props => [];
}

class DataSuccess<T> extends DataFetchState {
  final T data;
  DataSuccess({required this.data});

  @override
  List<Object?> get props => [];
}

class DataFailure<T> extends DataFetchState {
  final Object? error;
  DataFailure({required this.error});

  @override
  List<Object?> get props => [];
}