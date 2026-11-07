import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tako/core/constants/assets_manager.dart';
import 'package:tako/core/utils/app_colors.dart';
import 'package:tako/core/utils/styles.dart';

class CommunityChatScreen extends StatefulWidget {
  const CommunityChatScreen({super.key});

  @override
  State<CommunityChatScreen> createState() => _CommunityChatScreenState();
}

class _CommunityChatScreenState extends State<CommunityChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection('community_chat').add({
      'text': _messageController.text.trim(),
      'senderId': user.uid,
      'senderName': user.displayName ?? "Anonymous",
      'timestamp': FieldValue.serverTimestamp(),
    });

    _messageController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          // HEADER
          Container(
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            decoration: const BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Community Chat',
                style: getHeadTextStyle().copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // CHAT AREA
          Expanded(
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    AssetsManager.feed,
                    width: 800,
                    height: 800,
                    fit: BoxFit.cover,
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance
                          .collection('community_chat')
                          .orderBy('timestamp')
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.secondaryColor,
                        ),
                      );
                    }

                    final messages = snapshot.data!.docs;
                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(bottom: 60),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final data =
                            messages[index].data() as Map<String, dynamic>;
                        final isMe =
                            data['senderId'] ==
                            FirebaseAuth.instance.currentUser!.uid;

                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment:
                                isMe
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (!isMe) ...[
                                CircleAvatar(
                                  radius: 16,
                                  child: Text(
                                    data['senderName'][0].toUpperCase(),
                                  ),
                                ),
                                const SizedBox(width: 6),
                              ],
                              Column(
                                crossAxisAlignment:
                                    isMe
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          isMe
                                              ? AppColors.secondaryColor
                                              : AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (!isMe)
                                          Text(
                                            data['senderName'],
                                            style: getSmallTextStyle().copyWith(
                                              color: AppColors.secondaryColor,
                                            ),
                                          ),
                                        Text(data['text'] ?? ''),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    data['timestamp'] != null
                                        ? (data['timestamp'] as Timestamp)
                                            .toDate()
                                            .toLocal()
                                            .toString()
                                            .substring(11, 16)
                                        : '',
                                    style: getSmallTextStyle().copyWith(
                                      color: AppColors.secondaryColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),

          // INPUT FIELD
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      cursorColor: AppColors.secondaryColor,
                      style: getSmallTextStyle().copyWith(
                        color:
                            AppColors
                                .secondaryColor,
                      ),
                      decoration: InputDecoration(
                        hintText: "Message...",
                        hintStyle: getSmallTextStyle().copyWith(
                          color: AppColors.secondaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.secondaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Iconsax.send_1,
                      color: AppColors.secondaryColor,
                    ),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
