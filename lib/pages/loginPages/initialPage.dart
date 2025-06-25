
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Initialpage extends StatefulWidget {
  const Initialpage({super.key});

  @override
  State<Initialpage> createState() => _InitialpageState();
}

class _InitialpageState extends State<Initialpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 5,
            children: [
              SvgPicture.asset("assets/logo/midTitle.svg"),
              Text("From school to home, we’ve got you covered.",style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w100,
              ),

              )
            ],
          ),
        ),
    );
  }
}