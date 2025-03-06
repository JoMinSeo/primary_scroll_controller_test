import 'package:flutter/material.dart';
import 'package:primary_scroll_controller_test/core/visible_detect_scroll_controller_notifier.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          final scrollController = PrimaryScrollController.of(context);

          if (scrollController.hasClients) {
            scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
          }
        },
        child: const Icon(Icons.arrow_back),
      ),
      body: VisibleDetectScrollControllerNotifier(
        visibleDetectorKey: const ValueKey<String>('MessagePage'),
        child: ListView.builder(
          primary: true,
          itemBuilder: (context, index) {
            return Text('Message Page $index');
          },
          itemCount: 100,
        ),
      ),
    );
  }
}
