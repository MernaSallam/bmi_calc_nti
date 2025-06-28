import 'package:firstflut/features/BMI_Calc/data/model/bmi_data_model.dart';
import 'package:firstflut/features/BMI_Calc/presentation/UI_Screens/secndScreen.dart';
import 'package:firstflut/features/BMI_Calc/presentation/components/CustumButton.dart';
import 'package:firstflut/features/BMI_Calc/presentation/components/app_image.dart';
import 'package:firstflut/features/BMI_Calc/presentation/components/theme/app_colors.dart';
import 'package:firstflut/features/BMI_Calc/presentation/controller/git_bmi/cubit/bmi_result_cubit.dart';
import 'package:firstflut/features/BMI_Calc/presentation/controller/git_bmi/cubit/bmi_result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen(
      {super.key,
      //required this.bmiModel,
      required this.gender,
      required this.name,
      required this.age,
      required this.height,
      required this.weight});

  //final BmiDataModel bmiModel;
  final String gender;
  final String name;
  final int age;
  final String height;
  final String weight;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<BmiResultCubit>().getBmiRes(
            height: widget.height,
            weight: widget.weight,
            unit: 'metric',
            gender: widget.gender,
            name: widget.name,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocConsumer<BmiResultCubit, BmiResultState>(
      listener: (context, state) {
        if (state is BmiResError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is BmiResLoading) {
          return const Scaffold(
            backgroundColor: AppColor.bg_color,
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is BmiResSuccess) {
          final BmiDataModel model = state.bmiModel;
          return Scaffold(
              backgroundColor: AppColor.bg_color,
              appBar: AppBar(
                backgroundColor: AppColor.bg_color,
                title: const Text('BMI Result',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xCC3C3B77),
                    )),
                centerTitle: true,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //personal info card
                        Container(
                            margin: const EdgeInsets.all(20),
                            padding: const EdgeInsets.all(10),
                            width: screenSize.width,
                            height: screenSize.height * 0.4,
                            decoration: BoxDecoration(
                              color: AppColor.purple,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //profile card
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    children: [
                                      //PS Info
                                      Column(
                                        children: [
                                          Text(widget.name,
                                              style: const TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white)),
                                          const SizedBox(width: 20),
                                          Text(
                                              'A ${widget.age} years old ${widget.gender.toUpperCase()}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white)),
                                        ],
                                      ),

                                      const SizedBox(height: 20),

                                      //BMI Info
                                      Column(
                                        children: [
                                          Text(model.bmi.toStringAsFixed(1),
                                              style: const TextStyle(
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white)),
                                          const SizedBox(width: 20),
                                          const Text('BMI Calc',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          //height  Info
                                          Column(
                                            children: [
                                              Text(widget.height.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white)),
                                              const SizedBox(width: 20),
                                              const Text('Height (cm)',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white)),
                                            ],
                                          ),
                                          const SizedBox(width: 20),
                                          //vertical divider
                                          const SizedBox(
                                            height: 50,
                                            child: VerticalDivider(
                                              color: AppColor.white,
                                              thickness: 2,
                                              width: 20,
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Column(
                                            children: [
                                              Text(widget.weight.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white)),
                                              const SizedBox(width: 20),
                                              const Text('Weight (Kg)',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white)),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                //body image
                                SvgPicture.asset(AppImage.body),
                              ],
                            )),
                        const SizedBox(height: 25),

                        // Result Analysis card
                        Container(
                          height: screenSize.height * 0.4,
                          width: screenSize.width,
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColor.analysisCardBg,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //tittle 1
                                Text(model.risk,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white)),
                                const SizedBox(height: 5),
                                //subtitle
                                Text(model.summary,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white)),
                                const SizedBox(height: 10),
                                //analysis
                                Text(
                                    //maxLines: 7,
                                    model.recommendation,
                                    style: const TextStyle(
                                        //overflow: TextOverflow.ellipsis,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white)),
                              ],
                            ),
                          ),
                        ),

                        //Button to go back to the first screen
                        Button(
                            Nextpage: BlocProvider(
                              create: (context) => BmiResultCubit(),
                              child: BMIscreen(),
                            ),
                            BTtxt: 'Calc BMI Again'),
                        const SizedBox(height: 20),
                      ]),
                ),
              ));
        }

        // Handle other states
        else if (state is BmiResError) {
          return Center(child: Text("Error: ${state.message}"));
        }

        // Default case if no state matches
        return const Scaffold(
          backgroundColor: AppColor.bg_color,
          body: SizedBox(),
        );
      },
    );
  }
}
