import 'package:flutter/material.dart';

import '../constants/categories.dart';

class CategoryDropdown extends StatelessWidget {
  final String myLabel;
  final String hint;
  String? selectedCategory;
  final String? Function(String?) myValidator;

  Function(String?) onChanged;
  CategoryDropdown(
      {Key? key,
      required this.myLabel,
      required this.hint,
      required this.myValidator,
      required this.onChanged})
      : super(key: key);

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
        DropdownButtonFormField(
          items: categories
              .map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                ),
              )
              .toList(),
          onChanged: onChanged,
          value: selectedCategory,
          validator: myValidator,
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
        )
      ],
    );
  }
}
