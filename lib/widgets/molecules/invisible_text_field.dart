import 'package:flutter/material.dart';
import 'package:input_with_keyboard_control/input_with_keyboard_control.dart';

class InvisibleTextField extends StatefulWidget {
  const InvisibleTextField({
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  final Function onSubmit;

  @override
  _InvisibleTextFieldState createState() => _InvisibleTextFieldState();
}

class _InvisibleTextFieldState extends State<InvisibleTextField> {
  final universalPdaFocusNode = InputWithKeyboardControlFocusNode();
  final universalPdaTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (!universalPdaFocusNode.hasFocus) universalPdaFocusNode.requestFocus();
    return SizedBox(
      width: 0,
      height: 0,
      child: Visibility(
        child: Focus(
          onFocusChange: (hasFocus) {
            if (!hasFocus) {
              universalPdaFocusNode.requestFocus();
            }
          },
          child: InputWithKeyboardControl(
            focusNode: universalPdaFocusNode,
            //keyboardType: TextInputType.none,
            width: 0,
            onSubmitted: (value) {
              widget.onSubmit(value);
              universalPdaTextEditingController.clear();
            },
            controller: universalPdaTextEditingController,
          ),
        ),
        visible: false,
        maintainSize: true,
        maintainInteractivity: true,
        maintainState: true,
        maintainAnimation: true,
      ),
    );
  }

  @override
  void dispose() {
    universalPdaTextEditingController.dispose();
    universalPdaFocusNode.dispose();
    super.dispose();
  }
}
