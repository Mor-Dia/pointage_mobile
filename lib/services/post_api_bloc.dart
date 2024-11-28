import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yogivida_mobile/services/api/actions/postData.dart';

part 'post_api_event.dart';
part 'post_api_state.dart';

class PostApiBloc extends Bloc<PostApiEvent, PostApiState> {
  PostApiBloc() : super(PostApiInitial()) {
    on<PostApiMakeCall>((event, emit) async {
      await makeCall(event);
    });
  }

  makeCall(event) async {
    final response = await postApiData(event.endpoint, event.parameters);
    print("HERE GOES CALL REPONSE ${response.body}");
  }
}

