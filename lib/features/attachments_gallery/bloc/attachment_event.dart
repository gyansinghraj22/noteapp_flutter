part of 'attachment_bloc.dart';

@immutable
abstract class AttachmentEvent {}

class AttachmentInitialEvent extends AttachmentEvent {}

class AttachmentGetEvent extends AttachmentEvent {
  final Map<String, dynamic> formData;

  AttachmentGetEvent({required this.formData});
}

class AttachmentCreateEvent extends AttachmentEvent {
  final Map<String, dynamic> formData;

  AttachmentCreateEvent({required this.formData});
}

class AttachmentDeleteEvent extends AttachmentEvent {
  final Map<String, dynamic> formData;

  AttachmentDeleteEvent({required this.formData});
}
