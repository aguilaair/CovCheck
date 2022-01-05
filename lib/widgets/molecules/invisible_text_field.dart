import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            onEditingComplete: () {},
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

// ignore: slash_for_doc_comments
/**
https://github.com/jelufe/input_with_keyboard_control
---
Copyright © 2021 Jean Lucas Ferreira de Sousa

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 */

class InputWithKeyboardControl extends EditableText {
  /// startShowKeyboard is initial value to show or not the keyboard when the widget is created, default value is false
  final bool startShowKeyboard;

  /// focusNode is responsible for controlling the focus of the field, this parameter is required
  @override
  // ignore: overridden_fields
  final InputWithKeyboardControlFocusNode focusNode;

  /// width is responsible for set the widget size, This parameter is required
  final double width;

  /// buttonColorEnabled is responsible for set color in button when is enabled, default value is Colors.blue
  final Color buttonColorEnabled;

  /// buttonColorDisabled is responsible for set color in button when is disabled, default value is Colors.black
  final Color buttonColorDisabled;

  /// underlineColor is responsible for set color in underline BorderSide, default value is Colors.black
  final Color underlineColor;

  /// showUnderline is responsible for showing or not the underline in the widget, default value is true
  final bool showUnderline;

  /// showButton is responsible for showing or not the button to control the keyboard, default value is true
  final bool showButton;

  InputWithKeyboardControl({
    Key? key,
    required TextEditingController controller,
    TextStyle style = const TextStyle(color: Colors.black, fontSize: 18),
    Color cursorColor = Colors.black,
    bool autofocus = false,
    Color? selectionColor,
    this.startShowKeyboard = false,
    void Function(String)? onSubmitted,
    void Function()? onEditingComplete,
    required this.focusNode,
    required this.width,
    this.buttonColorEnabled = Colors.blue,
    this.buttonColorDisabled = Colors.black,
    this.underlineColor = Colors.black,
    this.showUnderline = true,
    this.showButton = true,
  }) : super(
          key: key,
          controller: controller,
          focusNode: focusNode,
          style: style,
          cursorColor: cursorColor,
          autofocus: autofocus,
          selectionColor: selectionColor,
          backgroundCursorColor: Colors.black,
          onSubmitted: onSubmitted,
          onEditingComplete: onEditingComplete,
        );

  @override
  EditableTextState createState() {
    // ignore: no_logic_in_create_state
    return InputWithKeyboardControlState(
        startShowKeyboard,
        focusNode,
        width,
        buttonColorEnabled,
        buttonColorDisabled,
        underlineColor,
        showUnderline,
        showButton);
  }
}

class InputWithKeyboardControlState extends EditableTextState {
  /// showKeyboard is initial value to show or not the keyboard when the widget is created, default value is false
  bool showKeyboard;

  /// focusNode is responsible for controlling the focus of the field, this parameter is required
  final InputWithKeyboardControlFocusNode focusNode;

  /// width is responsible for set the widget size, This parameter is required
  final double width;

  /// buttonColorEnabled is responsible for set color in button when is enabled, default value is Colors.blue
  final Color buttonColorEnabled;

  /// buttonColorDisabled is responsible for set color in button when is disabled, default value is Colors.black
  final Color buttonColorDisabled;

  /// underlineColor is responsible for set color in underline BorderSide, default value is Colors.black
  final Color underlineColor;

  /// showUnderline is responsible for showing or not the underline in the widget, default value is true
  final bool showUnderline;

  /// showButton is responsible for showing or not the button to control the keyboard, default value is true
  final bool showButton;

  // funcionListener is responsible for controller focusNode listener
  late Function funcionListener;

  @override
  void initState() {
    funcionListener = () {
      if (focusNode.hasFocus) requestKeyboard();
    };

    focusNode.addListener(funcionListener as void Function());
    super.initState();
  }

  @override
  void dispose() {
    focusNode.removeListener(funcionListener as void Function());
    super.dispose();
  }

  InputWithKeyboardControlState(
      this.showKeyboard,
      this.focusNode,
      this.width,
      this.buttonColorEnabled,
      this.buttonColorDisabled,
      this.underlineColor,
      this.showUnderline,
      this.showButton);

  toggleShowKeyboard(bool value) {
    setState(() {
      showKeyboard = !value;
    });

    if (!showKeyboard) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      focusNode.requestFocus();
    } else {
      SystemChannels.textInput.invokeMethod('TextInput.show');
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget widget = super.build(context);
    return SizedBox(
      width: width,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                  decoration: showUnderline
                      ? UnderlineTabIndicator(
                          borderSide: BorderSide(color: underlineColor),
                        )
                      : null,
                  child: widget),
            ),
            SizedBox(
              width: size.width * 0.01,
            ),
            showButton
                ? InkWell(
                    onTap: () {
                      toggleShowKeyboard(showKeyboard);
                    },
                    child: Icon(
                      Icons.keyboard,
                      color: showKeyboard
                          ? buttonColorEnabled
                          : buttonColorDisabled,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  @override
  void requestKeyboard() {
    super.requestKeyboard();

    if (!showKeyboard) SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

class InputWithKeyboardControlFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    return false;
  }
}
