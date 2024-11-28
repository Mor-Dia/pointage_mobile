part of 'post_api_bloc.dart';

sealed class PostApiEvent extends Equatable {
  const PostApiEvent();
}

class PostApiMakeCall extends PostApiEvent {
  final String endpoint;
  final Map<String, dynamic>? parameters;
  const PostApiMakeCall({required this.endpoint, this.parameters});

  @override
  List<Object?> get props => [parameters, endpoint];
}