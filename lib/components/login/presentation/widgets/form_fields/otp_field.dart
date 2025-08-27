import 'package:flutter/cupertino.dart';

class OtpField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onFieldSubmitted;

  const OtpField({
    super.key,
    required this.controller,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoFormSection.insetGrouped(
      header: Row(
        children: [
          const Text('OTP 验证码'),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey5,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '可选',
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 12,
                color: CupertinoColors.systemGrey,
              ),
            ),
          ),
        ],
      ),
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
            placeholder: '输入 OTP 验证码（可选）',
            textInputAction: TextInputAction.done,
            onSubmitted: onFieldSubmitted,
            keyboardType: TextInputType.number,
            maxLength: 6,
            decoration: null,
          ),
        ),
      ],
    );
  }
}
