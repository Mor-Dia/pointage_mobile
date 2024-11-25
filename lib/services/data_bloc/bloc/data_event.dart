part of 'data_bloc.dart';

abstract class DataFetchEvent {}

class FetchDataEvent<T> extends DataFetchEvent {
  final Map<String, dynamic>? filter;
  final bool loadNewData;
  FetchDataEvent({this.filter, this.loadNewData = true});
}

class PostDataEvent<T> extends DataFetchEvent {
  final Map<String, dynamic> body;
  PostDataEvent(this.body);
}

class RefreshDataEvent<T> extends DataFetchEvent {
  final Map<String, dynamic>? filter;
  RefreshDataEvent({this.filter});
}

class CancelDataFetchingEvent extends DataFetchEvent {
  final String reason;
  CancelDataFetchingEvent({this.reason = "No reason"});
}
