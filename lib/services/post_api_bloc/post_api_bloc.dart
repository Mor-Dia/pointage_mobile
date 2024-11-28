import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'post_api_event.dart';
part 'post_api_state.dart';

class PostApiBloc extends Bloc<PostApiEvent, PostApiState> {
  PostApiBloc() : super(PostApiInitial()) {
    on<PostApiEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
