import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.onChanged,
      required this.myLabel,
      required this.hint,
      this.controller,
      this.myValidator,
      this.textInputType = TextInputType.text,
      this.myObscureText = false,
      this.disabled = false,
      this.showBorder = false})
      : super(key: key);

  final Function(String?) onChanged;
  final String myLabel;
  final String hint;
  final TextInputType textInputType;
  final bool myObscureText;
  final bool disabled;

  final TextEditingController? controller;
  final String? Function(String?)? myValidator;
  final bool showBorder;

  OutlineInputBorder outlineInputBorder() {
    if (showBorder) {
      return OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
      );
    } else {
      return OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          myLabel,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          enabled: !disabled,
          keyboardType: textInputType,
          onChanged: onChanged,
          controller: controller,
          validator: myValidator,
          obscureText: myObscureText,
          decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: const Color(0xFFEFEFEF),
              enabledBorder: outlineInputBorder(),
              focusedBorder: outlineInputBorder(),
              errorBorder: outlineInputBorder(),
              focusedErrorBorder: outlineInputBorder(),
              disabledBorder: outlineInputBorder(),
              border: outlineInputBorder()),
        ),
      ],
    );
  }
}
