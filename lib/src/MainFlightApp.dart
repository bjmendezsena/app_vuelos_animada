import 'package:flutter/material.dart';
import 'package:prueba/src/widgets/FlighTimeLine.dart';
import 'package:prueba/src/widgets/FlightForm.dart';

class MainFlightApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: FlightHomeApp(),
    );
  }
}

class FlightHomeApp extends StatefulWidget {
  @override
  _FlightHomeAppState createState() => _FlightHomeAppState();
}

enum FlightView { form, timeline }

class _FlightHomeAppState extends State<FlightHomeApp> {
  FlightView flightView = FlightView.form;
  void _onFlightPressed() {
    setState(() {
      flightView = FlightView.timeline;
    });
  }

  @override
  Widget build(BuildContext context) {
    final headerHeight = MediaQuery.of(context).size.height * 0.32;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              height: headerHeight,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.32,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color(0xFFE04148),
                      Color(0xFFD85774),
                    ])),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text(
                        'Air Asia',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          HeaderButton(
                            title: 'One way',
                            selected: true,
                          ),
                          HeaderButton(
                            title: 'Round',
                          ),
                          HeaderButton(
                            title: 'Multicity',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                left: 10,
                right: 10,
                top: headerHeight / 2,
                bottom: 0,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child:
                                  TabButton(title: 'Flight', selected: true)),
                          Expanded(
                              child:
                                  TabButton(title: 'Train', selected: false)),
                          Expanded(
                              child: TabButton(title: 'Bus', selected: false)),
                        ],
                      ),
                      Expanded(
                          child: flightView == FlightView.form
                              ? FlightForm(onTab: _onFlightPressed)
                              : FlighTimeLine())
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String title;
  final bool selected;

  const TabButton({required this.title, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              title.toUpperCase(),
              style: TextStyle(color: selected ? Colors.red : Colors.grey),
            ),
          ),
          if (selected)
            Container(
              height: 2,
              color: Colors.red,
            )
        ],
      ),
    );
    ;
  }
}

class HeaderButton extends StatelessWidget {
  final String title;
  final bool selected;

  const HeaderButton({required this.title, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: selected ? Colors.white : null,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.white)),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 13),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(color: selected ? Colors.red : Colors.white),
        ),
      )),
    );
  }
}
