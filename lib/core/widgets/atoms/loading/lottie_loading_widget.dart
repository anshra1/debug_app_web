import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieLoadingWidget extends StatefulWidget {
  const LottieLoadingWidget({
    super.key,
    this.width,
    this.height,
    this.autoPlay = true,
    this.repeat = true,
  });
  final double? width;
  final double? height;
  final bool autoPlay;
  final bool repeat;

  @override
  State<LottieLoadingWidget> createState() => _LottieLoadingWidgetState();
}

class _LottieLoadingWidgetState extends State<LottieLoadingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(
        seconds: 5,
      ), // Initial duration, will be updated when Lottie loads
      vsync: this,
    );

    if (widget.autoPlay) {
      if (widget.repeat) {
        _controller.repeat();
      } else {
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/lottie/file_uploading.json',
      controller: _controller,
      width: widget.width,
      height: widget.height,
      onLoaded: (composition) {
        // Update controller duration to match the actual animation duration
        _controller.duration = composition.duration;

        if (widget.autoPlay) {
          if (widget.repeat) {
            _controller.repeat();
          } else {
            _controller.forward();
          }
        }
      },
    );
  }

  // Public methods to control the animation
  void play() => _controller.forward();
  void playFromStart() => _controller.forward(from: 0);
  void pause() => _controller.stop();
  void reset() => _controller.reset();
  void repeatAnimation() => _controller.repeat();
}
