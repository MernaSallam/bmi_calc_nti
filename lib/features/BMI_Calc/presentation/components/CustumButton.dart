// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.Nextpage,
    required this.BTtxt,
  });
  final Widget Nextpage;
  final String BTtxt;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(332, 45),
            backgroundColor: const Color(0xFF484783),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Nextpage;
              },
            ),
          );
        },
        child: Text(
          BTtxt,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ));
  }
}
