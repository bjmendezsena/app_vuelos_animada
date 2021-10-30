import 'package:flutter/material.dart';
import 'package:prueba/src/widgets/FlighRoutes.dart';

const _airplaneSize = 30.0;
const _dotSize = 15.0;
const _planeDuration = 400;

class FlighTimeLine extends StatefulWidget {
  @override
  _FlighTimeLineState createState() => _FlighTimeLineState();
}

class _FlighTimeLineState extends State<FlighTimeLine> {
  bool animate = false;
  bool animateCards = false;
  bool animateButon = false;

  void initAnimation() async {
    setState(() {
      animate = !animate;
    });

    await Future.delayed(const Duration(milliseconds: 1200));

    setState(() {
      animateCards = true;
    });
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      animateButon = true;
    });
  }

  void _onRoutesPressed() {
    Navigator.of(context)
        .push(PageRouteBuilder(pageBuilder: (_, animation1, __) {
      return FadeTransition(
        opacity: animation1,
        child: FlighRoutes(),
      );
    }));
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      initAnimation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final centerDot = constraints.maxWidth / 2 - _dotSize / 2;
      final cardAnimationDuration = 200;

      return Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: _planeDuration),
            left: constraints.maxWidth / 2 - _airplaneSize / 2,
            top: animate ? 20 : constraints.maxHeight - _airplaneSize - 10,
            bottom: 0.0,
            child: AircraftAndLine(),
          ),
          AnimatedPositioned(
              duration: Duration(
                  milliseconds:
                      animate ? _planeDuration + 200 : _planeDuration),
              left: centerDot,
              top: animate ? 80 : constraints.maxHeight,
              child: TimeLineDot(
                selected: true,
                displayCard: animateCards,
                delay: Duration(milliseconds: cardAnimationDuration),
              )),
          AnimatedPositioned(
              duration: Duration(
                  milliseconds:
                      animate ? _planeDuration + 400 : _planeDuration),
              right: centerDot,
              top: animate ? 140 : constraints.maxHeight,
              child: TimeLineDot(
                left: true,
                selected: false,
                displayCard: animateCards,
                delay: Duration(milliseconds: cardAnimationDuration * 2),
              )),
          AnimatedPositioned(
              duration: Duration(
                  milliseconds:
                      animate ? _planeDuration + 600 : _planeDuration),
              left: centerDot,
              top: animate ? 200 : constraints.maxHeight,
              child: TimeLineDot(
                selected: false,
                displayCard: animateCards,
                delay: Duration(milliseconds: cardAnimationDuration * 3),
              )),
          AnimatedPositioned(
              duration: Duration(
                  milliseconds:
                      animate ? _planeDuration + 600 : _planeDuration),
              right: centerDot,
              top: animate ? 260 : constraints.maxHeight,
              child: TimeLineDot(
                left: true,
                selected: true,
                displayCard: animateCards,
                delay: Duration(milliseconds: cardAnimationDuration * 4),
              )),
          if (animateButon)
            Align(
              alignment: Alignment.bottomCenter,
              child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 200),
                  child: FloatingActionButton(
                      backgroundColor: Colors.red,
                      child: Icon(Icons.check),
                      onPressed: _onRoutesPressed),
                  builder: (context, value, child) {
                    return Transform.scale(scale: value, child: child);
                  }),
            ),
        ],
      );
    });
  }
}

class TimeLineDot extends StatefulWidget {
  final bool selected;
  final bool displayCard;
  final bool left;
  final Duration delay;

  const TimeLineDot(
      {this.selected = false,
      this.displayCard = false,
      this.left = false,
      required this.delay});

  @override
  _TimeLineDotState createState() => _TimeLineDotState();
}

class _TimeLineDotState extends State<TimeLineDot> {
  bool animated = false;
  final _animationMillisecons = 100;

  void _animatedWithDelay() async {
    if (widget.displayCard) {
      await Future.delayed(widget.delay);
      setState(() {
        animated = true;
      });
    }
  }

  @override
  void didUpdateWidget(covariant TimeLineDot oldWidget) {
    _animatedWithDelay();
    super.didUpdateWidget(oldWidget);
  }

  Widget _buildCard() => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: _animationMillisecons),
        child: Container(
          color: Colors.grey.shade200,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('JFK + ORY'),
          ),
        ),
        builder: (context, value, child) {
          return Transform.scale(
              alignment:
                  widget.left ? Alignment.centerRight : Alignment.bottomLeft,
              scale: value,
              child: child);
        },
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (animated && widget.left) ...[
          _buildCard(),
          AnimatedContainer(
            duration: Duration(milliseconds: _animationMillisecons),
            width: widget.displayCard ? 10 : 0,
            height: 1,
            color: Colors.grey.shade400,
          ),
        ],
        Container(
          height: _dotSize,
          width: _dotSize,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.white,
              shape: BoxShape.circle),
          child: Padding(
            padding: EdgeInsets.all(3.0),
            child: CircleAvatar(
              backgroundColor: widget.selected ? Colors.red : Colors.green,
            ),
          ),
        ),
        if (animated && !widget.left) ...[
          AnimatedContainer(
            duration: Duration(milliseconds: _animationMillisecons),
            width: widget.displayCard ? 10 : 0,
            height: 1,
            color: Colors.grey.shade400,
          ),
          _buildCard(),
        ],
      ],
    );
  }
}

class AircraftAndLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _airplaneSize,
      child: Column(
        children: [
          Icon(
            Icons.flight,
            color: Colors.red,
            size: _airplaneSize,
          ),
          Expanded(
              child: Container(
            width: 5,
            color: Colors.grey[300],
          ))
        ],
      ),
    );
  }
}
