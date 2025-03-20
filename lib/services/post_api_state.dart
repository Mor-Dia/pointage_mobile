part of 'post_api_bloc.dart';

sealed class PostApiState extends Equatable {
  const PostApiState();
}

final class PostApiInitial extends PostApiState {
  @override
  List<Object?> get props => [];
}


final class PostApiProcessing extends PostApiState {
  const PostApiProcessing();
  @override
  List<Object?> get props => [];
}

final class PostApiSuccess extends PostApiState {
  final String? message;
  final dynamic data;

  const PostApiSuccess({this.message,this.data});
  @override
  List<Object?> get props => [message,data];
}

final class PostApiFailure extends PostApiState {
  final String? message;

  const PostApiFailure({this.message});
  @override
  List<Object?> get props => [message];
}
