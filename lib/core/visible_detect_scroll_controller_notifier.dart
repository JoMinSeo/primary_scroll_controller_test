import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScrollControllerNotification extends Notification {
  ScrollControllerNotification({required this.controller});

  final ScrollController controller;
}

class VisibleDetectScrollControllerNotifier extends StatelessWidget {
  const VisibleDetectScrollControllerNotifier({
    super.key,
    required this.visibleDetectorKey,
    required this.child,
  });

  final Key visibleDetectorKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: visibleDetectorKey,
      onVisibilityChanged: (info) {
        if (info.visibleFraction == 1) {
          ScrollControllerNotification(
            controller: PrimaryScrollController.of(context),
          ).dispatch(context);
        }
      },
      child: child,
    );
  }
}
