import 'package:flutter/material.dart';

class NavigationBox extends StatelessWidget {
  final String label;
  final Widget destinationScreen;
  final Color  boxColor;

  NavigationBox({required this.label, required this.destinationScreen,required this. boxColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationScreen),
        );
      },
      child: Container(
        width: 400,
        height: 100,
        margin: EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
           color: boxColor,
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}