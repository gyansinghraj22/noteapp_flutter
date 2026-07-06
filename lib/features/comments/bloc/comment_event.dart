part of 'comment_bloc.dart';


@immutable
abstract class CommentEvent {}

class CommentInitialEvent extends CommentEvent {}

class CommentGetEvent extends CommentEvent {
  final Map<String, dynamic> formData;

  CommentGetEvent({required this.formData});
}

class CommentCreateEvent extends CommentEvent {
  final Map<String, dynamic> formData;

  CommentCreateEvent({required this.formData});
}

class CommentDeleteEvent extends CommentEvent {
  final Map<String, dynamic> formData;

  CommentDeleteEvent({required this.formData});
}

class CommentUpdateEvent extends CommentEvent {
  final Map<String, dynamic> formData;

  CommentUpdateEvent({required this.formData});
}
