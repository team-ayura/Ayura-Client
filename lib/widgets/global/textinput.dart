import 'package:ayura/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:ayura/constants/styles.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.label,
    this.width,
    this.height,
    this.obscure,
    this.onInput,
    required this.errorMsg,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String label;
  final double? width;
  final double? height;
  final bool? obscure;
  final Function(String)? onInput;
  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Inter',
            color: AppColors.alternateGreyColor,
          ),
        ),
        SizedBox(
          width: width, // Set your desired width here
          child: TextField(
            obscureText: obscure ?? false,
            style: const TextStyle(backgroundColor: Colors.white),
            controller: controller,
            onChanged: onInput,
            decoration: AppStyles().inputDecoration(hintText, errorMsg),
          ),
        ),
      ],
    );
  }
}
