import 'package:flutter/cupertino.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const LoginButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: CupertinoButton.filled(
        onPressed: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(12),
        child: isLoading
            ? const CupertinoActivityIndicator(
                color: CupertinoColors.white,
              )
            : const Text(
                '登录',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
