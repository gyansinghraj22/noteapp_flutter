import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:noteapp/constants/key_string.dart';
import 'package:noteapp/core/utils/shared_pref.dart';
import 'package:noteapp/features/chat/screens/chat_detail_screen.dart';
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
    if (!forceRefresh && _hasLoaded) return;
    if (!mounted) return;
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

    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 8.h),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Messages',
                      style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w700),
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
          if (_isLoading)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_errorMessage != null)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_errorMessage!, textAlign: TextAlign.center),
                    TextButton.icon(
                      onPressed: () => _loadConversations(forceRefresh: true),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          else if (_conversations.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Text(
                    'No conversations yet',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final conversation = _conversations[index];
                    final title = (conversation['title'] ?? 'New chat').toString();
                    final count = (conversation['participantIds'] as List?)?.length ?? 0;
                    return Card(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.forum_rounded)),
                        title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
                        subtitle: Text('$count participants'),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ChatDetailScreen(conversation: conversation),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  childCount: _conversations.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
