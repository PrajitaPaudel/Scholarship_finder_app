import 'package:flutter/material.dart';

enum SnackbarType { success, failure, error }

class CustomSnackbar {
  static void showSnackbar(BuildContext context, String message, SnackbarType type) {
    final overlay = Overlay.of(context);

    late OverlayEntry overlayEntry; // Declare first

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getBackgroundColor(type),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    Icon(_getIcon(type), color: Colors.white, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () => overlayEntry.remove(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Auto-remove after 10 seconds
    Future.delayed(Duration(seconds: 10), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  static Color _getBackgroundColor(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return Colors.green.shade600;
      case SnackbarType.failure:
        return Colors.orange.shade700;
      case SnackbarType.error:
        return Colors.red.shade700;
      default:
        return Colors.grey;
    }
  }

  static IconData _getIcon(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return Icons.check_circle;
      case SnackbarType.failure:
        return Icons.warning_amber_rounded;
      case SnackbarType.error:
        return Icons.error_outline;
      default:
        return Icons.info;
    }
  }
}
