part of 'attachment_bloc.dart';

@immutable
abstract class AttachmentState {}

class AttachmentInitial extends AttachmentState {}

class AttachmentLoadingState extends AttachmentState {}

class AttachmentGetSuccessState extends AttachmentState {
  final dynamic response;

  AttachmentGetSuccessState({required this.response});
}

class AttachmentGetErrorState extends AttachmentState {
  final ErrorModel errorModel;

  AttachmentGetErrorState({required this.errorModel});
}

class AttachemenUploadSuccessState extends AttachmentState {
  final dynamic response;

  AttachemenUploadSuccessState({required this.response});
}

class AttachmentUploadErrorState extends AttachmentState {
  final ErrorModel errorModel;

  AttachmentUploadErrorState({required this.errorModel});
}

class AttachmentDeleteSuccessState extends AttachmentState {
  final dynamic response;

  AttachmentDeleteSuccessState({required this.response});
}

class AttachmentDeleteErrorState extends AttachmentState {
  final ErrorModel errorModel;

  AttachmentDeleteErrorState({required this.errorModel});
}
