import 'package:firstflut/features/BMI_Calc/presentation/UI_Screens/secndScreen.dart';
import 'package:firstflut/features/BMI_Calc/presentation/controller/git_bmi/cubit/bmi_result_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../components/CustumButton.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'asset/first_img.svg',
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xFF7876CD),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 45,
                  ),
                  // Title 1
                  const Text(
                    'Know Your Body Better , Get Your BMI Score in Less Than a Minute!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 36 / 24,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // Title 2
                  const Text(
                    'It takes just 30 seconds, and your health is worth it !',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFF8F9FF),
                      height: 22 / 16,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(
                    color: Color.fromRGBO(248, 249, 255, 0.65),
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  Button(
                    Nextpage: BlocProvider(
                      create: (context) => BmiResultCubit(),
                      child: BMIscreen(),
                    ),
                    BTtxt: 'Get Started',
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                ],
              ),
            )
          ]),
    );
  }
}
