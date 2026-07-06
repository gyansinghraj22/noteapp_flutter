part of 'comment_bloc.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoadingState extends CommentState {}

class CommentGetSuccessState extends CommentState {
  final dynamic response;

  CommentGetSuccessState({required this.response});
}

class CommentGetErrorState extends CommentState {
  final ErrorModel errorModel;

  CommentGetErrorState({required this.errorModel});
}

class CommentCreateSuccessState extends CommentState {
  final dynamic response;

  CommentCreateSuccessState({required this.response});
}

class CommentCreateErrorState extends CommentState {
  final ErrorModel errorModel;

  CommentCreateErrorState({required this.errorModel});
}

class CommentDeleteSuccessState extends CommentState {
  final dynamic response;

  CommentDeleteSuccessState({required this.response});
}

class CommentDeleteErrorState extends CommentState {
  final ErrorModel errorModel;

  CommentDeleteErrorState({required this.errorModel});
}
