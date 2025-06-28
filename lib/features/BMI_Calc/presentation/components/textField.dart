import 'package:firstflut/features/BMI_Calc/presentation/components/theme/app_colors.dart';
import 'package:flutter/material.dart';

// Custom text field widget

class textField extends StatelessWidget {
   textField({super.key, required this.txt , this.controller});
  final String txt;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // Title text
            Text(txt,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF505152),
                )),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 48,
          child: TextField(
             controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.fill_color,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFFD0D1D6),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFFD0D1D6),
                  width: 1,
                ),
              ),
              hintText: 'Enter your $txt',
            ),
          ),
        ),
      ],
    );
  }
}
