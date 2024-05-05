import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:pinnaclefx/Models/reuseable_widgets.dart';

class LearnPage extends StatefulWidget {
  final String firstName;
   LearnPage({super.key, required this.firstName});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            'Welcome back',
                            style: tabHeaderTextstyle),
                        Image.asset(
                          'asset/images/profile.png',
                          height: 30,
                          filterQuality: FilterQuality.medium,
                        )
                      ],
                    ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 20),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.27,
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color.fromRGBO(115, 3, 217, 1)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.20,
                            child: Icon(
                              Icons.play_circle_outlined,
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                          Text(
                            'Introduction to Forex Trading',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          LinearProgressIndicator()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.15,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(115, 3, 217, 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star, color: Colors.white, size: 35),
                              Icon(Icons.star, color: Colors.white, size: 35),
                              Icon(Icons.star, color: Colors.white, size: 35),
                              Icon(Icons.star, color: Colors.white, size: 35),
                              Icon(Icons.star, color: Colors.white, size: 35),
                            ],
                          ),
                          Text(
                            'Learning Streak',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Center(child: SemicircularProgressBar(percentage: 67)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SemicircularProgressBar extends StatelessWidget {
  final double percentage;
  final Color backgroundColor;
  final Color progressColor;
  final double strokeWidth;

  SemicircularProgressBar({
    this.percentage = 0,
    this.backgroundColor = const Color.fromRGBO(179, 93, 253, 1),
    this.progressColor = const Color.fromRGBO(115, 3, 217, 1),
    this.strokeWidth = 45,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.2,
              child: CustomPaint(
                foregroundPainter: _SemicircularProgressPainter(
                  percentage: percentage,
                  backgroundColor: backgroundColor,
                  progressColor: progressColor,
                  strokeWidth: strokeWidth,
                ),
              )),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            child: Column(
              children: [
                Text(
                  '${percentage.toInt()}%',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  'Trading Proficiency',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Color.fromRGBO(33, 17, 71, 1)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SemicircularProgressPainter extends CustomPainter {
  final double percentage;
  final Color backgroundColor;
  final Color progressColor;
  final double strokeWidth;

  _SemicircularProgressPainter({
    required this.percentage,
    required this.backgroundColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      rect,
      math.pi,
      math.pi,
      false,
      paint,
    );

    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      rect,
      math.pi,
      percentage * math.pi / 100,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
