import 'package:flutter/material.dart';

import '../utils/const.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String?)? onchange;
  final String hintText;
  final int? maxLength;
  final int? maxLine;
  final Widget? suffixIcon;
  final Color? borderColor;
  final TextInputType? keyBoardType;
  final bool? editable;

  const CustomTextForm({
    Key? key,
    required this.controller,
    required this.validator,
    this.onchange,
    required this.hintText,
    this.maxLength,
    this.maxLine,
    this.suffixIcon,
    this.borderColor,
    this.keyBoardType,
    this.editable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        enabled: editable,
        keyboardType: keyBoardType ?? TextInputType.text,
        controller: controller,
        validator: validator,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onchange,
        maxLength: maxLength,
        maxLines: maxLine,
        decoration: InputDecoration(
            fillColor: editable == false ? Colors.grey : null,
            filled: editable == false ? true : false,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                    color: AppConst.primaryColor // borderColor,
                    )),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide:
                    const BorderSide(color: Colors.indigo // borderColor,
                        )),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            hintText: hintText,
            suffixIcon: suffixIcon ??
                IconButton(
                    onPressed: () {
                      controller.clear();
                    },
                    icon: const Icon(Icons.clear))),
      ),
    );
  }
}
