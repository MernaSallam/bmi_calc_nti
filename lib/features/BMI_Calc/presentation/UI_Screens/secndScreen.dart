import 'package:firstflut/features/BMI_Calc/presentation/UI_Screens/resultScreen.dart';
import 'package:firstflut/features/BMI_Calc/presentation/components/Image_container.dart';
import 'package:firstflut/features/BMI_Calc/presentation/components/app_image.dart';
import 'package:firstflut/features/BMI_Calc/presentation/components/textField.dart';
import 'package:firstflut/features/BMI_Calc/presentation/components/theme/app_colors.dart';
import 'package:firstflut/features/BMI_Calc/presentation/controller/git_bmi/cubit/bmi_result_cubit.dart';
import 'package:firstflut/features/BMI_Calc/presentation/controller/git_bmi/cubit/bmi_result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BMIscreen extends StatefulWidget {
  BMIscreen({super.key});

  @override
  State<BMIscreen> createState() => _BMIscreenState();
}

class _BMIscreenState extends State<BMIscreen> {
  // Variables
  final _formKey = GlobalKey<FormState>();
  String genderSelection = '';

  DateTime? selectedDate;
  int? age;

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController Weightcontroller = TextEditingController();
  final TextEditingController heightcontroller = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

 

  @override
  void dispose() {
    namecontroller.dispose();
    heightcontroller.dispose();
    Weightcontroller.dispose();
    super.dispose();
  }

  // Increment and Decrement Functions for height

  void _incrementHeight() {
    if (heightcontroller.text.isNotEmpty) {
      int value = int.parse(heightcontroller.text);
      heightcontroller.text = (value + 1).toString();
      setState(() {});
    } else {
      heightcontroller.text = '1';
      setState(() {});
    }
  }

  void _decrementHeight() {
    if (heightcontroller.text.isNotEmpty) {
      int value = int.parse(heightcontroller.text);
      if (value > 1) {
        heightcontroller.text = (value - 1).toString();
        setState(() {});
      }
    }
  }

/////////////////////////////////////////////////////////

  // Increment and Decrement Functions for weight

  void _incrementWeight() {
    if (Weightcontroller.text.isNotEmpty) {
      int value = int.parse(Weightcontroller.text);
      Weightcontroller.text = (value + 1).toString();
      setState(() {});
    } else {
      Weightcontroller.text = '1';
      setState(() {});
    }
  }

  void _decrementWeight() {
    if (Weightcontroller.text.isNotEmpty) {
      int value = int.parse(Weightcontroller.text);
      if (value > 1) {
        Weightcontroller.text = (value - 1).toString();
        setState(() {});
      }
    }
  }

/////////////////////////////////////////////////////////

  // function to calculate age from birth date
  int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  // Function to select date
  Future<void> pickBirthDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000), // تاريخ مبدئي
      firstDate: DateTime(1900), // أقدم تاريخ ممكن
      lastDate: DateTime.now(), // لا يمكن اختيار تاريخ مستقبلي
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
        age = calculateAge(picked);
      });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return BlocListener<BmiResultCubit, BmiResultState>(
      listener: (context, state) {
        if (state is BmiResSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                // bmiModel: state.bmiModel,
                gender: state.gender,
                name: state.name,
                age: age ?? 0,
                height: heightcontroller.text.trim(),
                weight: Weightcontroller.text.trim(),
              ),
            ),
          );
        } else if (state is BmiResError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
          backgroundColor: AppColor.bg_color,
          appBar: AppBar(
            backgroundColor: AppColor.bg_color,
            centerTitle: true,
            title: const Text('B M I',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A6143),
                )),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: BlocBuilder<BmiResultCubit, BmiResultState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        //name field
                        textField(txt: 'Name ', controller: namecontroller),
                        const SizedBox(
                          height: 20,
                        ),

                        //birthday field
                        TextFormField(
                          controller: _dateController,
                          readOnly: true,
                          onTap: () => pickBirthDate(context, _dateController),
                          decoration: InputDecoration(
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
                            labelText: "Birth Date",
                            suffixIcon: const Icon(Icons.calendar_today),
                            filled: true,
                            fillColor: AppColor.fill_color,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select your birth date';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        //Gender Selection
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Choose Gender',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF505152),
                                )),
                            const SizedBox(
                              width: 10,
                            ),

                            //Choices
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 28, right: 28),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildGenderSelection(
                                    imagePath: AppImage.maleImage,
                                    gender: 'male',
                                    label: 'Male',
                                  ),
                                  const SizedBox(width: 50),
                                  _buildGenderSelection(
                                    imagePath: AppImage.femaleImage,
                                    gender: 'female',
                                    label: 'Female',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        // Height Field
                        const Text('Your Height',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF505152),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildNumberField(
                          controller: heightcontroller,
                          onIncrement: _incrementHeight,
                          onDecrement: _decrementHeight,
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        //Weight Field
                        const Text('Your Weight',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF505152),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildNumberField(
                          controller: Weightcontroller,
                          onIncrement: _incrementWeight,
                          onDecrement: _decrementWeight,
                        ),
                        const SizedBox(
                          height: 24,
                        ),

                       // Calculate Button 
                        ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate() ||
                                genderSelection.isEmpty ||
                                selectedDate == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please fill all fields"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => BmiResultCubit(),
                                  child: ResultScreen(
                                    gender: genderSelection,
                                    name: namecontroller.text.trim().isEmpty
                                        ? 'User'
                                        : namecontroller.text.trim(),
                                    age: age ?? 0,
                                    height: heightcontroller.text.trim(),
                                    weight: Weightcontroller.text.trim(),
                                  ),
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.purpl2,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text(
                            'Calculate BMI',
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          )),
    );
  }

  // Widget to build the gender selection options
  Widget _buildGenderSelection({
    required String imagePath,
    required String gender,
    required String label,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              genderSelection = gender;
            });
          },
          child: IamgeContainer(
            genderSelection: genderSelection,
            path: imagePath,
            value: gender,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  // Widget to build the number field with increment and decrement buttons
  Widget _buildNumberField({
    required TextEditingController controller,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.lightBlue2,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide.none,
        ),
        prefixIcon: GestureDetector(
          onTap: onDecrement,
          child: const Icon(Icons.remove),
        ),
        suffixIcon: GestureDetector(onTap: onIncrement, child: Icon(Icons.add)),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        double? number = double.tryParse(value.trim());
        if (number == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }
}
