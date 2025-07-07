import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastService {
  ToastService(this.toastification);
  final Toastification toastification;

  void showErrorToast({
    required String title,
    String? description,
    Duration? duration,
  }) {
    toastification.showCustom(
      alignment: Alignment.topRight,
      autoCloseDuration: duration ?? const Duration(seconds: 4),
      builder: (BuildContext context, ToastificationItem item) {
        return Container(
          width: 400,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.red.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red.shade700),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.red.shade900,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red.shade400, size: 20),
                    onPressed: () => toastification.dismiss(item),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              if (description != null) ...[
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.red.shade700,
                    fontSize: 14,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              ToastTimerAnimationBuilder(
                item: item,
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    value: value,
                    backgroundColor: Colors.red.shade100,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red.shade400),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
