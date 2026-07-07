import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:noteapp/core/common/loading_overlay/loading_overlay.dart';
import 'package:noteapp/core/common/show_dialog/show_dialog.dart';

import '../bloc/captcha_event.dart';
import '../bloc/catpcha_bloc.dart';
import '../bloc/captcha_state.dart';

class CaptchaWidget extends StatefulWidget {
  final VoidCallback? onSuccess;
  final Function(String errorMessage)? onError;
  final void Function(String? captchaId, String? captchaAnswer)? onChanged;
  final bool autoFetch;

  const CaptchaWidget({
    super.key,
    this.onSuccess,
    this.onError,
    this.onChanged,
    this.autoFetch = true,
  });

  @override
  State<CaptchaWidget> createState() => _CaptchaWidgetState();
}

class _CaptchaWidgetState extends State<CaptchaWidget> {
  final TextEditingController _answerController = TextEditingController();
  final LoadingOverlay _loadingOverlay = GetIt.instance.get<LoadingOverlay>();
  Timer? _countdownTimer;
  int _remainingSeconds = 0;
  String? _currentCaptchaId;
  String? _currentCaptchaAnswer;

  void _notifyParent() {
    widget.onChanged?.call(_currentCaptchaId, _currentCaptchaAnswer);
  }

  @override
  void initState() {
    super.initState();

    if (widget.autoFetch) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.read<CaptchaBloc>().add(const FetchCaptchaEvent());
        }
      });
    }
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _answerController.dispose();
    super.dispose();
  }

  void _startCountdown(int expiresInSeconds) {
    _countdownTimer?.cancel();
    setState(() {
      _remainingSeconds = expiresInSeconds;
    });

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_remainingSeconds <= 1) {
        timer.cancel();
        setState(() {
          _remainingSeconds = 0;
        });
        return;
      }

      setState(() {
        _remainingSeconds -= 1;
      });
    });
  }

  void _submitAnswer(String captchaId) {
    final answer = _answerController.text.trim();
    if (answer.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter an answer')));
      return;
    }

    context.read<CaptchaBloc>().add(
      SubmitCaptchaAnswerEvent(captchaId: captchaId, answer: answer),
    );
  }

  void _refreshCaptcha() {
    _answerController.clear();
    _currentCaptchaAnswer = null;
    _currentCaptchaId = null;
    _notifyParent();
    context.read<CaptchaBloc>().add(const RefreshCaptchaEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CaptchaBloc, CaptchaState>(
      listener: (context, state) {
        if (state is CaptchaLoading || state is CaptchaValidating) {
          _loadingOverlay.show(context);
        } else {
          _loadingOverlay.hide();
        }

        if (state is CaptchaLoaded) {
          _currentCaptchaId = state.captcha.captchaId;
          _currentCaptchaAnswer = null;
          _notifyParent();
          _startCountdown(state.captcha.expiresInSeconds);
        } else if (state is CaptchaInitial) {
          _countdownTimer?.cancel();
          setState(() {
            _remainingSeconds = 0;
          });
          _currentCaptchaId = null;
          _currentCaptchaAnswer = null;
          _notifyParent();
        }

        if (state is CaptchaValidationSuccess) {
          widget.onSuccess?.call();
          ShowDialog(context: context).showErrorStateDialog(
            title: 'Success',
            body: 'CAPTCHA verified successfully!',
          );
        } else if (state is CaptchaValidationFailure) {
          widget.onError?.call(state.errorMessage);
          ShowDialog(context: context).showErrorStateDialog(
            title: 'Verification Failed',
            body: state.errorMessage,
            onTab: () {
              Navigator.pop(context);
              _answerController.clear();
            },
          );
        } else if (state is CaptchaExpired) {
          widget.onError?.call('CAPTCHA expired. Please refresh.');
          ShowDialog(context: context).showErrorStateDialog(
            title: 'Expired',
            body: 'CAPTCHA expired. Please refresh.',
            onTab: () {
              Navigator.pop(context);
              _refreshCaptcha();
            },
          );
        } else if (state is CaptchaError) {
          widget.onError?.call(state.errorMessage);
          ShowDialog(context: context).showErrorStateDialog(
            title: 'Error',
            body: state.errorMessage,
            onTab: () {
              Navigator.pop(context);
              context.read<CaptchaBloc>().add(const FetchCaptchaEvent());
            },
          );
        }
      },
      child: BlocBuilder<CaptchaBloc, CaptchaState>(
        builder: (context, state) {
          if (state is CaptchaLoaded || state is CaptchaValidating) {
            final captcha =
                state is CaptchaLoaded
                    ? state.captcha
                    : (state as CaptchaValidating).captcha;

            final remainingSeconds =
                _remainingSeconds > 0
                    ? _remainingSeconds
                    : captcha.expiresInSeconds;

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'CAPTCHA Verification',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Expires in: ${remainingSeconds}s',
                        style: TextStyle(
                          color:
                              remainingSeconds < 30
                                  ? Colors.red
                                  : Colors.grey.shade700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  CustomPaint(
                    size: const Size(180, 60),
                    painter: CaptchaPainter(captcha.question),
                  ),
                  Text(
                    captcha.question,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // const SizedBox(height: 12),
                  // Text(
                  //   'Captcha ID: ${captcha.captchaId}',
                  //   style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  // ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _answerController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      _currentCaptchaAnswer =
                          value.trim().isEmpty ? null : value.trim();
                      _notifyParent();
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your answer',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: ElevatedButton(
                  //         onPressed: () => _submitAnswer(captcha.captchaId),
                  //         child: const Text('Verify'),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 8),
                  //     OutlinedButton(
                  //       onPressed: _refreshCaptcha,
                  //       child: const Text('Refresh'),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            );
          }

          if (state is CaptchaInitial) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'CAPTCHA Verification',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CaptchaBloc>().add(
                        const FetchCaptchaEvent(),
                      );
                    },
                    child: const Text('Load CAPTCHA'),
                  ),
                ],
              ),
            );
          }

          if (state is CaptchaValidationSuccess) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(12),
                color: Colors.green.shade50,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green.shade700,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'CAPTCHA Verified!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class CaptchaPainter extends CustomPainter {
  final String text;
  CaptchaPainter(this.text);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.grey.shade300
          ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width-20, size.height), paint);

    // Draw random distortion lines
    final random = Random();
    final linePaint = Paint()..strokeWidth = 2;
    for (int i = 0; i < 5; i++) {
      linePaint.color = Colors
          .primaries[random.nextInt(Colors.primaries.length)]
          .withOpacity(0.5);
      canvas.drawLine(
        Offset(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        ),
        Offset(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        ),
        linePaint,
      );
    }

    // Draw the CAPTCHA text characters
    for (int i = 0; i < text.length; i++) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: text[i],
          style: TextStyle(
            color: Colors.primaries[random.nextInt(Colors.primaries.length)],
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontStyle: random.nextBool() ? FontStyle.italic : FontStyle.normal,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      canvas.save();
      // Apply slight rotation transformations to confuse simple screen scrapers
      canvas.translate(15.0 + (i * 25), 15.0 + random.nextInt(10));
      canvas.rotate((random.nextInt(20) - 10) * pi / 180);
      textPainter.paint(canvas, const Offset(0, 0));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
