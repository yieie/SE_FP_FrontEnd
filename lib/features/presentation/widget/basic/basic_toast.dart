import 'package:flutter/material.dart';

class BasicToast {
  static OverlayEntry? _currentToast;

  static void show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    Color backgroundColor = Colors.white,
    Color textColor = Colors.black,
    double fontSize = 14.0,
    ToastPosition position = ToastPosition.bottom,
  }) {
    _currentToast?.remove(); // 移除前一個 toast（避免重疊）

    final overlay = Overlay.of(context);
    final screenSize = MediaQuery.of(context).size;

    double top;
    switch (position) {
      case ToastPosition.top:
        top = 50;
        break;
      case ToastPosition.center:
        top = screenSize.height / 2 - 30;
        break;
      case ToastPosition.bottom:
      default:
        top = screenSize.height - 100;
        break;
    }

    final entry = OverlayEntry(
      builder: (_) => Positioned(
        top: top,
        left: screenSize.width * 0.1,
        width: screenSize.width * 0.8,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      ),
    );

    _currentToast = entry;
    overlay.insert(entry);

    Future.delayed(duration, () {
      entry.remove();
      if (_currentToast == entry) _currentToast = null;
    });
  }
}

enum ToastPosition {
  top,
  center,
  bottom,
}
