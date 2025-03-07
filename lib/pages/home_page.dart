import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primary_scroll_controller_test/app/router/routes.dart';
import 'package:primary_scroll_controller_test/core/visible_detect_scroll_controller_notifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _appBarColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar = AppBar(
      backgroundColor: _appBarColor,
      title: const Text('Home Page'),
      actions: [
        IconButton(
          onPressed: () => const HomeDetailRoute().go(context),
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: VisibleDetectScrollControllerNotifier(
          visibleDetectorKey: const ValueKey<String>(HomeRoute.name),
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollNotification) {
              _updateColorOfAppBar(scrollNotification.metrics);

              return false;
            },
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
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.7),
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

  /// 스크롤 시에 [AppBar]의 색상을 변경합니다.
  void _updateColorOfAppBar(ScrollMetrics metrics) {
    // if (metrics.pixels < 0) return;

    bool didScrolled = metrics.pixels > 0;
    Color appBarColor = didScrolled ? Colors.indigo : Colors.transparent;

    return setState(() => _appBarColor = appBarColor);
  }
}
