import 'package:firstflut/features/BMI_Calc/presentation/components/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IamgeContainer extends StatelessWidget {
  const IamgeContainer({
    super.key,
    required this.genderSelection,
    required this.path,
    required this.value,
  });

  final String genderSelection;
  final String path;
  final String value;

  @override
  Widget build(BuildContext context) {
    final isSelected = genderSelection == value;
    return Container(
      padding: const EdgeInsets.all(0.2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColor.lightBlue2,
        border: Border.all(
          color: isSelected ? AppColor.purple : Colors.transparent,
          width: 4,
        ),
      ),
      child: SvgPicture.asset(
        path,
        fit: BoxFit.cover,
      ),
    );
  }
}