import 'package:flutter/material.dart';
import 'package:primary_scroll_controller_test/app/router/routes.dart';
import 'package:primary_scroll_controller_test/core/visible_detect_scroll_controller_notifier.dart';

class HomeDetailPage extends StatelessWidget {
  const HomeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar = AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text('Home Detail Page'),
    );

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: VisibleDetectScrollControllerNotifier(
          visibleDetectorKey: const ValueKey<String>(HomeDetailRoute.path),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12) + const EdgeInsets.only(top: 20),
            primary: true,
            itemBuilder: (context, index) {
              return _buildItem(context, index);
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

  Widget _buildItem(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          'Home Detail Page $index',
          style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
