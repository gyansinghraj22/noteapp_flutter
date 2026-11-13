import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:noteapp/constants/key_string.dart';
import 'package:noteapp/core/utils/shared_pref.dart';
import 'package:noteapp/features/chat/service/chat_realtime_service.dart';
import 'package:noteapp/features/chat/service/chat_service.dart';

class ChatDetailScreen extends StatefulWidget {
  final Map<String, dynamic> conversation;

  const ChatDetailScreen({super.key, required this.conversation});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = GetIt.instance.get<ChatService>();
  final ChatRealtimeService _realtimeService = ChatRealtimeService();
  final List<Map<String, dynamic>> _messages = [];

  late final int _conversationId =
      (widget.conversation['id'] as num?)?.toInt() ?? 0;
  final int _currentUserId = int.tryParse(
        SharedPref.getStringValue(KeyString.userID.name),
      ) ??
      -1;

  bool _isLoading = false;
  bool _isSending = false;
  bool _isConnected = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    if (_conversationId == 0 || !mounted) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _chatService.getConversationMessages(_conversationId);
    result.fold((messages) {
      _messages
        ..clear()
        ..addAll(messages.map(_normalizeMessage));
      _errorMessage = null;
    }, (error) {
      _errorMessage = error.message ?? 'Unable to load messages';
    });

    if (mounted) {
      setState(() => _isLoading = false);
      _connectRealtime();
    }
  }

  void _connectRealtime() {
    _realtimeService.connect(
      conversationId: _conversationId,
      onMessage: _upsertMessage,
      onConnectionChanged: (connected) {
        if (mounted && _isConnected != connected) {
          setState(() => _isConnected = connected);
        }
      },
    );
  }

  Map<String, dynamic> _normalizeMessage(Map<String, dynamic> message) {
    final conversation = message['conversation'];
    final sender = message['sender'];
    return {
      ...message,
      'conversationId': message['conversationId'] ??
          (conversation is Map ? conversation['id'] : _conversationId),
      'senderId': message['senderId'] ?? (sender is Map ? sender['id'] : null),
      'senderName': message['senderName'] ??
          (sender is Map ? sender['username'] : null),
    };
  }

  void _upsertMessage(Map<String, dynamic> message) {
    if (!mounted) return;
    final normalized = _normalizeMessage(message);
    final messageId = normalized['id']?.toString();
    final existingIndex = messageId == null
        ? -1
        : _messages.indexWhere((item) => item['id']?.toString() == messageId);

    setState(() {
      if (existingIndex >= 0) {
        _messages[existingIndex] = normalized;
      } else {
        _messages.add(normalized);
      }
    });
  }

  Future<void> _sendMessage() async {
    final content = _messageController.text.trim();
    if (content.isEmpty || _conversationId <= 0 || _isSending) return;

    setState(() => _isSending = true);
    final result = await _chatService.sendMessage(
      conversationId: _conversationId,
      content: content,
    );

    result.fold((sentMessage) {
      _messageController.clear();
      // When connected, the server's STOMP broadcast (including this sender)
      // updates the list. Keep a REST fallback for a disconnected socket.
      if (!_isConnected) _upsertMessage(_normalizeMessage(sentMessage));
    }, (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Unable to send message')),
        );
      }
    });

    if (mounted) setState(() => _isSending = false);
  }

  bool _isMine(Map<String, dynamic> message) {
    final senderId = message['senderId'];
    return senderId is num && senderId.toInt() == _currentUserId;
  }

  @override
  void dispose() {
    _messageController.dispose();
    _realtimeService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = (widget.conversation['title'] ?? 'New chat').toString();
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
            Text(
              _isConnected ? 'Live' : 'Connecting…',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: _isConnected ? Colors.green : null,
                  ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _errorMessage != null
                      ? Center(
                          child: TextButton.icon(
                            onPressed: _loadMessages,
                            icon: const Icon(Icons.refresh),
                            label: Text(_errorMessage!),
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            final message = _messages[index];
                            final mine = _isMine(message);
                            return Align(
                              alignment: mine
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10.h),
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * .75,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 11.h,
                                ),
                                decoration: BoxDecoration(
                                  color: mine
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(18.r),
                                ),
                                child: Text(
                                  (message['content'] ?? '').toString(),
                                  style: TextStyle(
                                    color: mine
                                        ? Colors.white
                                        : Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).colorScheme.outline.withOpacity(.1),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      minLines: 1,
                      maxLines: 4,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        filled: true,
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.r),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  SizedBox(
                    width: 52.w,
                    height: 52.w,
                    child: FloatingActionButton(
                      onPressed: _isSending ? null : _sendMessage,
                      child: _isSending
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.send_rounded),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
