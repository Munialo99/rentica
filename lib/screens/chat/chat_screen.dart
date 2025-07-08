import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_styles.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Chat', style: AppStyles.headlineStyle1.copyWith(color: AppStyles.textBlack)),
        backgroundColor: AppStyles.whiteColor,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Your chats will appear here.',
          style: AppStyles.textStyle.copyWith(color: AppStyles.textGrey),
        ),
      ),
    );
  }
}