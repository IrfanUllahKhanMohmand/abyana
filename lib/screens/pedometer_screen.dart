import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

class PedometerScreen extends StatefulWidget {
  const PedometerScreen({super.key});

  @override
  State<PedometerScreen> createState() => _PedometerScreenState();
}

class _PedometerScreenState extends State<PedometerScreen> {
  late Stream<StepCount> _stepCountStream;
  int _steps = 0;
  bool _isRunning = true;
  int _initialSteps = 0;
  int _lastSavedSteps = 0;

  // Time tracking
  int _seconds = 0;
  Timer? _timer;

  // Distance calculation (average stride length in meters)
  final double _strideLength = 0.762; // Average stride length

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _startTimer();
  }

  void _requestPermission() async {
    if (await Permission.activityRecognition.request().isGranted) {
      _initPedometer();
    } else {
      // Show dialog to explain why permission is needed
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Permission Required'),
          content: const Text(
              'This app needs activity recognition permission to count steps.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _requestPermission();
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }
  }

  void _initPedometer() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(
      _onStepCount,
      onError: _onStepCountError,
      cancelOnError: true,
    );
  }

  void _onStepCount(StepCount event) {
    if (_initialSteps == 0) {
      _initialSteps = event.steps;
      _lastSavedSteps = event.steps;
    }

    if (_isRunning) {
      setState(() {
        _steps = event.steps - _initialSteps;
      });
    } else {
      _lastSavedSteps = event.steps;
    }
  }

  void _onStepCountError(error) {
    if (kDebugMode) {
      print('Pedometer error: $error');
    }
  }

  void _togglePedometer() {
    setState(() {
      _isRunning = !_isRunning;

      if (_isRunning) {
        _startTimer();
        _initialSteps = _lastSavedSteps - _steps;
      } else {
        _pauseTimer();
      }
    });
  }

  void _resetPedometer() {
    setState(() {
      _steps = 0;
      _seconds = 0;
      _initialSteps = _lastSavedSteps;

      if (!_isRunning) {
        _isRunning = true;
        _startTimer();
      }
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isRunning) {
        setState(() {
          _seconds++;
        });
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
  }

  String _formatTime() {
    int minutes = _seconds ~/ 60;
    return '$minutes mins';
  }

  double _calculateDistance() {
    // Convert steps to kilometers (steps * stride length in meters / 1000)
    return (_steps * _strideLength / 1000);
  }

  String _formatDistance() {
    return _calculateDistance().toStringAsFixed(2);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedometer'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Main card with step counter
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 220,
                      width: 220,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Progress indicator
                          CustomPaint(
                            size: const Size(220, 220),
                            painter: CircleProgressPainter(
                              progress: _steps /
                                  1000, // Assuming 1000 steps is the goal
                              progressColor: Colors.blue,
                              backgroundColor: Colors.grey[300]!,
                            ),
                          ),
                          // Steps counter
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Steps',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '$_steps',
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          // Play/Pause button
                          Positioned(
                            bottom: 0,
                            child: FloatingActionButton(
                              mini: true,
                              backgroundColor: Colors.blue,
                              onPressed: _togglePedometer,
                              child: Icon(
                                _isRunning ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Time and Distance cards
            Row(
              children: [
                // Time card
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: Colors.blue,
                            size: 28,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _formatTime(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Time',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Distance card
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.directions_run,
                            color: Colors.blue,
                            size: 28,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _formatDistance(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Km',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Reset button (added feature)
            ElevatedButton.icon(
              onPressed: _resetPedometer,
              icon: const Icon(Icons.refresh),
              label: const Text('Reset'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleProgressPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;

  CircleProgressPainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    final strokeWidth = 12.0;

    // Background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressAngle = 2 * 3.14159 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14159 / 2, // Start from top
      progressAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
