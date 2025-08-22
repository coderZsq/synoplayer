import 'package:flutter/cupertino.dart';
import '../../quickconnect/entities/auth_login/auth_login_response.dart';

class LoginStatus extends StatelessWidget {
  final AuthLoginResponse response;
  final VoidCallback onBack;

  const LoginStatus({
    super.key,
    required this.response,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: CupertinoColors.systemGreen.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.checkmark_circle_fill,
                color: CupertinoColors.systemGreen,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '登录成功！',
                  style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: CupertinoColors.systemGreen,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (response.data?.account != null) ...[
            _buildInfoRow('账户', response.data!.account!),
          ],
          if (response.data?.sid != null) ...[
            _buildInfoRow('会话 ID', response.data!.sid!),
          ],
          if (response.data?.synotoken != null) ...[
            _buildInfoRow('Syno Token', response.data!.synotoken!),
          ],
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              onPressed: onBack,
              child: const Text('返回登录'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: CupertinoColors.systemGrey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'Menlo',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
