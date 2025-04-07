import 'package:flutter/material.dart';
import 'dart:async';
import 'weight.dart';
import 'target.dart';

void main() {
  runApp(const AgeScreen());
}

class AgeScreen extends StatelessWidget {
  const AgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Age Screen Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const _AgeScreenState(),
    );
  }
}

class _AgeScreenState extends StatefulWidget {
  const _AgeScreenState();

  @override
  State<_AgeScreenState> createState() => AgeScreenState();
}

class AgeScreenState extends State<_AgeScreenState> {
  double _selectedHeight = 20; // Default Age set to 50 cm (middle of 0-100)
  final ScrollController _scrollController = ScrollController();
  Timer? _debounceTimer;

  // Positioning variables
  final double rulerLeft = 34; // Horizontal position from left
  final double rulerTop = 30;  // Vertical position from top
  final double rulerWidth = 240;
  final double rulerHeight = 105;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double markerCenterOffset = (rulerWidth - 5) / 2;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        final double initialPosition = (_selectedHeight - 0) * 20 - markerCenterOffset;
        if (initialPosition >= 0 && initialPosition <= _scrollController.position.maxScrollExtent) {
          _scrollController.animateTo(
            initialPosition,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFFEEE8),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 393,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 32),
                    SizedBox(
                      width: 332,
                      child: Column(
                        children: [
                          const Text(
                            'Age',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (rowIndex) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(1, (index) {
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height: 5,
                                    width: 55,
                                    margin: const EdgeInsets.fromLTRB(1, 2, 10, 0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        colors: rowIndex == 3
                                            ? [const Color(0xFFB19589), const Color(0xFFB19589)]
                                            : [const Color(0xFFDECEC7), const Color(0xFFDECEC7)],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  );
                                }),
                              );
                            }),
                          ),
                          const SizedBox(height: 32),
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Select Your Age!",
                              style: TextStyle(
                                fontSize: 27,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            'Age is In Years\n(you can change it later)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF909090),
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 47),
                    Container(
                      width: 369,
                      height: 230,
                      decoration: BoxDecoration(
                        color: const Color(0xFFB09489),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: Container(
                          width: 308,
                          height: 165,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Stack(
                            children: [
                              // Positioned ruler
                              Positioned(
                                left: rulerLeft,
                                top: rulerTop,
                                child: SizedBox(
                                  width: rulerWidth,
                                  height: rulerHeight,
                                  child: NotificationListener<ScrollNotification>(
                                    onNotification: (scrollNotification) {
                                      if (scrollNotification is ScrollUpdateNotification) {
                                        _debounceTimer?.cancel();
                                        _debounceTimer = Timer(const Duration(milliseconds: 50), () {
                                          setState(() {
                                            double scrollOffset = _scrollController.offset;
                                            double adjustedOffset = scrollOffset + markerCenterOffset;
                                            _selectedHeight = (adjustedOffset / 20).roundToDouble() + 0;
                                            if (_selectedHeight < 0) _selectedHeight = 0;
                                            if (_selectedHeight > 100) _selectedHeight = 100;
                                          });
                                        });
                                      }
                                      return true;
                                    },
                                    child: SingleChildScrollView(
                                      controller: _scrollController,
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      child: CustomPaint(
                                        size: Size((100 - 0 + 1) * 20, rulerHeight),
                                        painter: RulerPainter(
                                          selectedHeight: _selectedHeight,
                                          verticalCenter: rulerHeight / 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Centered marker triangle
                              Positioned(
                                left: rulerLeft + (rulerWidth / 2) -20,
                                top: rulerTop + (rulerHeight / 2) + 10,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomPaint(
                                      size: const Size(14, 14),
                                      painter: MarkerPainter(),
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 0,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFEFE8),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: const Text(
                                        'Years',
                                        style: TextStyle(
                                          color: Color(0xFFC47958),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500
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
                    ),
                  ],
                ),
                Positioned(
                  bottom: 32,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const WeightScreen()), // Navigate to next screen
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            fixedSize: const Size(168, 62),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            side: const BorderSide(
                              color: Color(0x80909090),
                            ),
                          ),
                          child: const Text(
                            'Previous',
                            style: TextStyle(
                              color: Color(0xFFB09489),
                              fontSize: 24,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const TargetScreen()), // Navigate to next screen
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(166, 62),
                            backgroundColor: const Color(0xFFB09489),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Placeholder for the next screen
class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Next Screen'),
      ),
    );
  }
}

class RulerPainter extends CustomPainter {
  final double selectedHeight;
  final double verticalCenter;

  RulerPainter({required this.selectedHeight, required this.verticalCenter});

  @override
  void paint(Canvas canvas, Size size) {
    const double unitWidth = 20;
    const double regularTickHeight = 15;
    const double longerTickHeight = 25;
    const double textOffset = 10;

    final Paint tickPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;

    for (int i = 0; i <= 100; i++) {
      double x = (i - 0) * unitWidth;
      double tickHeight = (i % 5 == 0) ? longerTickHeight : regularTickHeight;

      canvas.drawLine(
        Offset(x, verticalCenter - tickHeight / 2),
        Offset(x, verticalCenter + tickHeight / 2),
        tickPaint,
      );

      if (i % 5 == 0 || i == 0 || i == 100) {
        final bool isSelected = (i == selectedHeight.round());
        final TextSpan span = TextSpan(
          text: '$i',
          style: TextStyle(
            color: isSelected ? Colors.black : const Color(0xFF909090),
            fontSize: isSelected ? 16 : 14,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        );
        final TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        tp.layout();
        tp.paint(canvas, Offset(x - tp.width / 2, verticalCenter - tickHeight / 2 - textOffset - tp.height));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is RulerPainter) {
      return oldDelegate.selectedHeight.round() != selectedHeight.round();
    }
    return true;
  }
}

class MarkerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint markerPaint = Paint()
      ..color = Color(0xFFC47959)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, markerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}