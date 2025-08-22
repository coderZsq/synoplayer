import 'package:flutter/cupertino.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onFieldSubmitted;

  const UsernameField({
    super.key,
    required this.controller,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoFormSection.insetGrouped(
      header: const Text('用户名'),
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
          child: CupertinoTextField(
            controller: controller,
            placeholder: '输入您的用户名',
            textInputAction: TextInputAction.next,
            onSubmitted: onFieldSubmitted,
            decoration: null,
          ),
        ),
      ],
    );
  }
}
