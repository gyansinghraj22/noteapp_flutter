import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/features/chat/service/chat_service.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen>
    with AutomaticKeepAliveClientMixin {
  final ChatService _chatService = GetIt.instance.get<ChatService>();

  final List<Map<String, dynamic>> _conversations = [];
  bool _isLoading = false;
  bool _hasLoaded = false;
  String? _errorMessage;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  Future<void> _loadConversations({bool forceRefresh = false}) async {
    if (!forceRefresh && _hasLoaded) {
      return;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _chatService.getMyConversations();

    result.fold((conversations) {
      _conversations
        ..clear()
        ..addAll(conversations);
      _hasLoaded = true;
      _errorMessage = null;
    }, (error) {
      _errorMessage = error.message ?? 'Unable to load chats';
    });

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _formatTime(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) {
      return 'Just now';
    }

    try {
      final parsed = DateTime.parse(dateTime);
      final now = DateTime.now();
      final difference = now.difference(parsed);

      if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      }
      if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      }
      if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      }
      return 'Just now';
    } catch (_) {
      return 'Recently';
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Messages',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _loadConversations(forceRefresh: true),
                    icon: const Icon(Icons.refresh_rounded),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(18.r),
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .outline
                        .withOpacity(0.12),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        'Search conversations',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            )
          else if (_errorMessage != null)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline_rounded,
                        size: 52.sp,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.4),
                      ),
                      SizedBox(height: 14.h),
                      Text(
                        _errorMessage ?? 'Something went wrong',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.7),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextButton.icon(
                        onPressed: () => _loadConversations(forceRefresh: true),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else if (_conversations.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.forum_outlined,
                        size: 54.sp,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.4),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'No chats yet',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Start a conversation to keep your notes and team updates flowing.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final conversation = _conversations[index];
                  final participantCount =
                      ((conversation['participantIds'] as List?) ?? []).length;
                  final title = (conversation['title'] ?? 'New chat').toString();
                  final updatedAt = conversation['updatedAt']?.toString();

                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Material(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(18.r),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18.r),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ChatDetailScreen(
                                conversation: conversation,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(14.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.r),
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .outline
                                  .withOpacity(0.12),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48.w,
                                height: 48.w,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context).colorScheme.primary,
                                      Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: const Icon(
                                  Icons.chat_bubble_rounded,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            title,
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          _formatTime(updatedAt),
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      '$participantCount participants',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16.sp,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.45),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }, childCount: _conversations.length),
              ),
            ),
        ],
      ),
    );
  }
}

class ChatDetailScreen extends StatefulWidget {
  final Map<String, dynamic> conversation;

  const ChatDetailScreen({super.key, required this.conversation});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = GetIt.instance.get<ChatService>();

  late final int _conversationId = (widget.conversation['id'] as num?)?.toInt() ?? 0;
  final List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;
  bool _isSending = false;
  bool _hasLoaded = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages({bool forceRefresh = false}) async {
    if (_conversationId == 0) {
      return;
    }

    if (!forceRefresh && _hasLoaded) {
      return;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _chatService.getConversationMessages(_conversationId);

    result.fold((messages) {
      _messages
        ..clear()
        ..addAll(messages);
      _hasLoaded = true;
      _errorMessage = null;
    }, (error) {
      _errorMessage = error.message ?? 'Unable to load messages';
    });

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty || _conversationId == 0) {
      return;
    }

    setState(() {
      _isSending = true;
    });

    final result = await _chatService.sendMessage(
      conversationId: _conversationId,
      content: message,
    );

    result.fold((sentMessage) {
      _messages.add(Map<String, dynamic>.from(sentMessage));
      _messageController.clear();
    }, (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Unable to send message')),
        );
      }
    });

    if (mounted) {
      setState(() {
        _isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = (widget.conversation['title'] ?? 'New chat').toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _errorMessage != null
                      ? Center(child: Text(_errorMessage!))
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            final message = _messages[index];
                            final isMine =
                                (message['senderId'] as num?)?.toInt() ==
                                    0 ||
                                (message['senderId'] as num?)?.toInt() ==
                                    null;

                            return Align(
                              alignment: isMine
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10.h),
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 0.72,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 12.h,
                                ),
                                decoration: BoxDecoration(
                                  color: isMine
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(18.r),
                                ),
                                child: Text(
                                  (message['content'] ?? '').toString(),
                                  style: TextStyle(
                                    color: isMine
                                        ? Colors.white
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface,
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
                    color: Theme.of(context)
                        .colorScheme
                        .outline
                        .withOpacity(0.08),
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
