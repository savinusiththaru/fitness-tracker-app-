import 'package:flutter/material.dart';

class WelcomeAnimation extends StatefulWidget {
  const WelcomeAnimation({super.key});

  @override
  _WelcomeAnimationState createState() => _WelcomeAnimationState();
}

class _WelcomeAnimationState extends State<WelcomeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentContainerIndex = 0;

  final List<Widget> containers = [
    Container2(),
    Container3(),
    Container4(),
    Container5(),
    Container6(),
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 700), () {
          setState(() {
            _currentContainerIndex = (_currentContainerIndex + 1) % containers.length;
          });
          _controller.reset();
          _controller.forward();
        });
      }
    });

    // Begin animation immediately (no "Get Ready!" text)
    Future.delayed(Duration(seconds: 2), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _animation,
        child: ScaleTransition(
          scale: _animation,
          child: containers[_currentContainerIndex],
        ),
      ),
    );
  }
}

class Container2 extends StatelessWidget {
  const Container2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 73,
        height: 73,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFFFEFE8),
        ),
      ),
    );
  }
}

class Container3 extends StatelessWidget {
  const Container3({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 152,
        height: 152,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFFFEFE8),
        ),
      ),
    );
  }
}

class Container4 extends StatelessWidget {
  const Container4({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 231,
        height: 231,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFFFEFE8),
        ),
      ),
    );
  }
}

class Container5 extends StatelessWidget {
  const Container5({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OverflowBox(
        maxWidth: double.infinity,
        maxHeight: double.infinity,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 700),
          curve: Curves.easeInOut,
          width: MediaQuery.of(context).size.width * 4, // or any desired size
          height: MediaQuery.of(context).size.height * 4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFFFEFE8),
          ),
        ),
      ),
    );
  }
}

class Container6 extends StatelessWidget {
  const Container6({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFFEFE8),
      child: Center(
        child: Image.asset(
          "assets/pics/dumbbell.png",
          width: 197,
          height: 98,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}