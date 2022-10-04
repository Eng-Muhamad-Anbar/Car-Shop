import 'package:flutter/material.dart';

class StateButton extends StatelessWidget {
  const StateButton(
      {Key? key,
      required this.onPressed,
      required this.isLoading,
      required this.text})
      : super(key: key);

  final void Function() onPressed;
  final bool isLoading;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading ? const CircularProgressIndicator() : Text(text),
    );
  }
}
