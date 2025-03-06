import 'package:flutter/material.dart';
import 'package:primary_scroll_controller_test/core/visible_detect_scroll_controller_notifier.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: VisibleDetectScrollControllerNotifier(
          visibleDetectorKey: const ValueKey<String>('MessagePage'),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12) + const EdgeInsets.only(top: 20),
            primary: true,
            itemBuilder: (context, index) {
              return _buildMessageItem(context, index);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 12);
            },
            itemCount: 100,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageItem(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          'Message Page $index',
          style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
