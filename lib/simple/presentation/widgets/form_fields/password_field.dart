import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onFieldSubmitted;

  const PasswordField({
    super.key,
    required this.controller,
    this.onFieldSubmitted,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoFormSection.insetGrouped(
      header: const Text('密码'),
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: CupertinoColors.separator,
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: CupertinoTextField(
                  controller: widget.controller,
                  placeholder: '输入您的密码',
                  obscureText: _obscureText,
                  textInputAction: TextInputAction.next,
                  onSubmitted: widget.onFieldSubmitted,
                  decoration: null,
                ),
              ),
              CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                  size: 20,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
