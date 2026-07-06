part of 'tag_bloc.dart';

@immutable
abstract class TagState {}

class TagInitial extends TagState {}

class TagLoadingState extends TagState {}

class TagGetSuccessState extends TagState {
  final dynamic response;

  TagGetSuccessState({required this.response});
}

class TagGetErrorState extends TagState {
  final ErrorModel errorModel;

  TagGetErrorState({required this.errorModel});
}

class TagCreateSuccessState extends TagState {
  final dynamic response;

  TagCreateSuccessState({required this.response});
}

class TagCreateErrorState extends TagState {
  final ErrorModel errorModel;

  TagCreateErrorState({required this.errorModel});
}

class TagDeleteSuccessState extends TagState {
  final dynamic response;

  TagDeleteSuccessState({required this.response});
}

class TagDeleteErrorState extends TagState {
  final ErrorModel errorModel;
  TagDeleteErrorState({required this.errorModel});
}
