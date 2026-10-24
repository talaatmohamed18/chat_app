import 'package:flutter/material.dart';

class ChatListTab extends StatelessWidget {
  const ChatListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Expanded(child: ChatMessages()),
          // NewMessage(),
        ],
      ),
    );
  }
}
