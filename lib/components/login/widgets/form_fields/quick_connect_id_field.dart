import 'package:flutter/cupertino.dart';

class QuickConnectIdField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onFieldSubmitted;

  const QuickConnectIdField({
    super.key,
    required this.controller,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoFormSection.insetGrouped(
      header: const Text('QuickConnect ID'),
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
            placeholder: '输入您的 QuickConnect ID',
            textInputAction: TextInputAction.next,
            onSubmitted: onFieldSubmitted,
            decoration: null,
          ),
        ),
      ],
    );
  }
}
