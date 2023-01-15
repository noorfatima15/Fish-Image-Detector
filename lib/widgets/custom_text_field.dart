import 'package:fish_detector/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onTap;
  final bool isSuffixIconVisible;
  final bool isPrefixIconVisible;
  final Function()? onSuffixIconTap;
  final Function(String?)? validator;
  const CustomTextField({
    Key? key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isSuffixIconVisible = false,
    this.isPrefixIconVisible = false,
    this.obscureText,
    this.keyboardType,
    this.controller,
    this.onChanged,
    this.validator,
    this.onSuffixIconTap,
    this.onSubmitted,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        onTap: onTap,
        validator: (value) => validator!(value),
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        style: TextStyles.textFieldInputStyle,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red),
          ),
          fillColor: Colors.white,
          prefixIcon: isPrefixIconVisible
              ? Icon(
                  prefixIcon,
                  color: Colors.cyan,
                )
              : null,
          suffixIcon: isSuffixIconVisible
              ? GestureDetector(
                  onTap: onSuffixIconTap,
                  child: Icon(
                    suffixIcon,
                    color: Colors.cyan,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
