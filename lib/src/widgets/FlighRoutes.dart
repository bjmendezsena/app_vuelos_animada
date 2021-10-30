import 'package:flutter/material.dart';

class FlighRoutes extends StatelessWidget {
  final animationDurationItems = 200;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  height: MediaQuery.of(context).size.width * 0.45,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Color(0xFFE04148),
                          Color(0xFFD85774),
                        ])),
                  ),
                ),
                Positioned(
                    top: MediaQuery.of(context).size.width * 0.10,
                    left: 20,
                    child: BackButton(color: Colors.white)),
                Positioned(
                    left: 10,
                    right: 10,
                    top: MediaQuery.of(context).size.width * 0.30,
                    child: Column(
                      children: [
                        RouteItem(
                            duration:
                                Duration(milliseconds: animationDurationItems)),
                        RouteItem(
                            duration: Duration(
                                milliseconds: animationDurationItems + 200)),
                        RouteItem(
                            duration: Duration(
                                milliseconds: animationDurationItems + 400)),
                        RouteItem(
                            duration: Duration(
                                milliseconds: animationDurationItems + 600)),
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RouteItem extends StatelessWidget {
  final Duration duration;

  const RouteItem({required this.duration});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 0.0),
      curve: Curves.decelerate,
      duration: duration,
      builder: (_, value, child) {
        return Transform.translate(
            child: child,
            offset: Offset(0.0, MediaQuery.of(context).size.height * value));
      },
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(children: [
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sahara',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'SHE',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ],
            )),
            Expanded(
                child: Column(
              children: [
                Icon(Icons.flight, color: Colors.red),
                Text(
                  'SE2351',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ],
            )),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Macao',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'SHE',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ],
            )),
          ]),
        ),
      ),
    );
  }
}
