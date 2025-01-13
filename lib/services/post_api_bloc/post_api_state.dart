part of 'post_api_bloc.dart';

sealed class PostApiState extends Equatable {
  const PostApiState();
}

final class PostApiInitial extends PostApiState {
  @override
  List<Object> get props => [];
}
