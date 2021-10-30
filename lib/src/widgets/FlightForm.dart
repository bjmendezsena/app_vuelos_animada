import 'package:flutter/material.dart';

class FlightForm extends StatelessWidget {
  final VoidCallback onTab;

  const FlightForm({Key? key, required this.onTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.flight_takeoff,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                        decoration: InputDecoration(labelText: 'From')),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.flight_land,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child:
                        TextField(decoration: InputDecoration(labelText: 'To')),
                  )
                ],
              ),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: MediaQuery.of(context).size.width / 3,
            child: FloatingActionButton(
              onPressed: onTab,
              backgroundColor: Colors.red,
              child: Icon(Icons.multiline_chart),
            ),
          )
        ],
      ),
    );
  }
}
