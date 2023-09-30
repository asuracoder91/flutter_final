import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm(
      {super.key,
      required this.text,
      required this.obscureText,
      required this.controller,
      required this.onSaved});
  final String text;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldSetter<String> onSaved;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: _isFocused
              ? Theme.of(context).colorScheme.outline
              : Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        focusNode: _focusNode,
        controller: widget.controller,
        obscureText: widget.obscureText,
        obscuringCharacter: '*',
        style: const TextStyle(fontWeight: FontWeight.w700),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(
            15,
            10,
            15,
            10,
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.secondaryContainer,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          labelText: widget.text,
          labelStyle: const TextStyle(
              color: Color(0xFF667085),
              fontSize: 16,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w500),
          floatingLabelStyle: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            height: 1.3,
            fontSize: 16,
          ),
        ),
        onSaved: widget.onSaved,
      ),
    );
  }
}
