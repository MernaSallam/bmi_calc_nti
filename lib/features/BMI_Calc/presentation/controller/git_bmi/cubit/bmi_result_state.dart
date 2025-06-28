import 'package:firstflut/features/BMI_Calc/data/model/bmi_data_model.dart';
import 'package:flutter/material.dart';

@immutable
sealed class BmiResultState {
  const BmiResultState();

  @override
  String toString() => runtimeType.toString();
}

final class BmiResInitial extends BmiResultState {
  const BmiResInitial();
}

class BmiResLoading extends BmiResultState {
  final String message;

  const BmiResLoading({this.message = "Calculating your BMI..."});
}

class BmiResError extends BmiResultState {
  final String message;
  const BmiResError(this.message);
}

class BmiResSuccess extends BmiResultState {
  final BmiDataModel bmiModel;
  final String gender;
  final String name;

  const BmiResSuccess({
    required this.bmiModel,
    required this.gender,
    required this.name,
  });
}