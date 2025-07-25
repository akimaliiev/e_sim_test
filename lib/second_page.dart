import 'dart:math' as math;
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> with SingleTickerProviderStateMixin {
  bool _expired = false;
  bool _alertEnabled = true;
  final double totalGB = 10.0;
  double _usedGB = 3.5;
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _progressController.value = _usedGB / totalGB;
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  void _toggleExpiration() {
    setState(() {
      _expired = !_expired;
      _usedGB = _expired ? 10.0 : 3.5;
      _progressController.animateTo(_usedGB / totalGB, curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF4CADC4);
    const Color progressColor = Color(0xFF33899E);
    const Color expiredBorderColor = Color(0xFFD54444);
    const Color expiredTextColor = Color(0xFFF71B1B);
    const Color titleTextColor = Color(0xFF155A6A);
    const double borderWidth = 25.6;
    const double circleSize = 314;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 8),
                        const Text(
                          "Flex Travel SIM",
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: titleTextColor,
                          ),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/avatar.png'),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                AnimatedBuilder(
                  animation: _progressController,
                  builder: (context, child) {
                    final fraction = _progressController.value;
                    final used = fraction * totalGB;
                    final usedText = used == used.floorToDouble()
                        ? used.toInt().toString()
                        : used.toStringAsFixed(1);

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        // Тень под кругом
                        Positioned(
                          bottom: 8,
                          child: ClipPath(
                            clipper: _CircleBottomShadowClipper(),
                            child: Container(
                              width: circleSize * 1.15,
                              height: circleSize * 0.3,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 30,
                                    spreadRadius: 55,
                                    offset: const Offset(0, 15),
                                  ),
                                  // BoxShadow(
                                  //   color: Colors.black.withOpacity(0.1),
                                  //   blurRadius: 70,
                                  //   spreadRadius: 100,
                                  //   offset: const Offset(0, 10),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Основной круг
                        CustomPaint(
                          size: Size(circleSize, circleSize),
                          painter: ProgressCirclePainter(
                            completePercent: fraction * 100,
                            lineColor: primaryColor,
                            completeColor: _expired ? expiredBorderColor : progressColor,
                            width: borderWidth,
                          ),
                        ),
                        // Внутреннее содержимое
                        SizedBox(
                          width: circleSize,
                          height: circleSize,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/logo.png', height: 36, color: titleTextColor),
                              const SizedBox(height: 6),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: Text(
                                  _expired ? 'TRAFFIC HAS ENDED' : 'YOUR TRAFFIC',
                                  key: ValueKey(_expired),
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: titleTextColor,
                                  ),
                                ),
                              ),
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 300),
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 68,
                                  fontWeight: FontWeight.bold,
                                  color: _expired ? expiredTextColor : titleTextColor,
                                ),
                                child: Text('$usedText GB'),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'of 10 GB used',
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 16,
                                  color: _expired ? expiredTextColor : titleTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const Spacer(),
                _expired
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: expiredBorderColor),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: const Center(
                          child: Text(
                            'Traffic has ended',
                            style: TextStyle(
                              color: expiredBorderColor,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Alert when 1h from expiration",
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 16,
                                color: progressColor,
                              ),
                            ),
                            Switch(
                              value: _alertEnabled,
                              onChanged: (value) => setState(() => _alertEnabled = value),
                              activeTrackColor: progressColor.withOpacity(0.5),
                              activeColor: progressColor,
                            ),
                          ],
                        ),
                      ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _toggleExpiration,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: progressColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 26),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: Text(
                    _expired ? "Add traffic (from \$5)" : "Add traffic (from \$5 / 10GB)",
                    style: const TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressCirclePainter extends CustomPainter {
  final Color lineColor;
  final Color completeColor;
  final double completePercent;
  final double width;

  ProgressCirclePainter({
    required this.lineColor,
    required this.completeColor,
    required this.completePercent,
    required this.width,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint baseLine = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    final Paint progressLine = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = math.min(size.width / 2, size.height / 2) - width / 2;

    canvas.drawCircle(center, radius, baseLine);

    final double sweepAngle = 2 * math.pi * (completePercent / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressLine,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
class _CircleBottomShadowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final radius = size.width / 2;
    
    // Рисуем нижнюю половину круга
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width / 2, 
      size.height * 1.5,
      size.width, 
      size.height * 0.7
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}