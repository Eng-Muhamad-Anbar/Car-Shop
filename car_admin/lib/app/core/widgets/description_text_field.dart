import 'package:flutter/material.dart';

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({
    Key? key,
    required this.onChanged,
    required this.myLabel,
    required this.hint,
    required this.myValidator,
    //required this.textFieldsChanges,
    this.textInputType = TextInputType.text,
    //this.myObscureText = false,
  }) : super(key: key);

  final Function(String?) onChanged;
  final String myLabel;
  final String hint;
  final TextInputType textInputType;
  //final bool myObscureText;

  final String? Function(String?) myValidator;
  //final void Function(String) textFieldsChanges;

  OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10),
    );
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
          keyboardType: textInputType,
          onChanged: onChanged,
          //obscureText: myObscureText,
          validator: myValidator,
          maxLines: 3,
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
