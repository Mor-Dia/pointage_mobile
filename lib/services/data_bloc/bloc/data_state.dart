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
  final Map<String, dynamic>? metadata;
  DataSuccess({required this.data, this.metadata});

  @override
  List<Object?> get props => [data, metadata];
}

class DataFailure<T> extends DataFetchState {
  final Object? error;
  DataFailure({required this.error});

  @override
  List<Object?> get props => [];
}