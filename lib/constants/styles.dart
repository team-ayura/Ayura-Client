import 'package:ayura/constants/colors.dart';
import 'package:flutter/material.dart';

//To access import this page and mention 'AppStyles.styleName'
//You can only apply a style for a widget if it has a style property with relavent type

class AppStyles {
  static const TextStyle headingTextStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
  );

  static const TextStyle subHeadingTextStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 20,
    color: AppColors.textColor,
  );

  static const TextStyle subheadingTextStyle2 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle subHeadingTextStyle3 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textColor,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    color: AppColors.textColor,
  );

  static const TextStyle bodyTextStyle2 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    color: Color(0xFF878787),
  );

  //mood tracking Questions styles
  static const TextStyle mainQuestionsStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 25,
    color: AppColors.textColor,
    fontWeight: FontWeight.bold,
  );

  //app bar title
  static const TextStyle appBarTitleStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 20,
    color: AppColors.textColor,
    fontWeight: FontWeight.bold,
  );

  static InputDecoration inputdec = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: AppColors.primaryColor, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.0),
    ),
  );
  InputDecoration inputDecoration(String placeholder, String error) {
    return InputDecoration(
      fillColor: Colors.transparent,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            const BorderSide(color: AppColors.alternateGreyColor, width: 1),
      ),
      hintText: placeholder,
      hintStyle: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
      ),
      errorText: error.isNotEmpty ? error : null,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
    );
  }

  static const BoxDecoration containerDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(8)),
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(69, 158, 158, 158),
        blurRadius: 10,
        offset: Offset(0, 1),
      ),
    ],
  );

  static ButtonStyle kCustomButtonStyle = ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(fontSize: 16),
    ),
    foregroundColor: MaterialStateProperty.all<Color>(
      Colors.white,
    ),
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return AppColors.accentColor;
        } else if (states.contains(MaterialState.disabled)) {
          return Colors.grey.shade300;
        }
        return AppColors.primaryColor;
      },
    ),
    padding: MaterialStateProperty.all<EdgeInsets>(
      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          color: Color(0xff23A6F0),
          width: 1.5,
        ),
      ),
    ),
  );

  // Add more styles as needed
}
