import 'package:farm/screens/login_page.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  static const routeName = '/signup';
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _agreed = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4E7D6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TopBar(
                leadingLabel: 'Back',
                trailingLabel: 'Help',
                onLeadingTap: _goToLogin,
                onTrailingTap: () => _showComingSoon(context),
              ),
              const SizedBox(height: 16),
              const Text(
                'Create your farm account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2C1C),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Set up your profile to start tracking animals, tasks, and health insights.',
                style: TextStyle(
                  color: Color(0xFF6A6F5B),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              _buildForm(),
              const SizedBox(height: 16),
              _buildGoogleButton(),
              const SizedBox(height: 12),
              _buildPhoneButton(),
              const SizedBox(height: 20),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LabeledField(label: 'Full name', hint: 'e.g. Alex Mwangi'),
          const SizedBox(height: 12),
          _LabeledField(label: 'Farm name (optional)', hint: 'Name of your farm'),
          const SizedBox(height: 12),
          _LabeledField(label: 'Email', hint: 'name@farm.com', keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 12),
          _LabeledField(
            label: 'Phone number',
            hint: 'e.g. +254 712 345 678',
            helperText: 'For alerts & WhatsApp tips',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12),
          _PasswordField(
            label: 'Password',
            hint: 'Create a password',
            obscure: _obscurePassword,
            onToggle: () => setState(() => _obscurePassword = !_obscurePassword),
          ),
          const SizedBox(height: 12),
          _PasswordField(
            label: 'Confirm password',
            hint: 'Re-enter your password',
            obscure: _obscureConfirm,
            onToggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Checkbox(
                value: _agreed,
                activeColor: const Color(0xFF2F7D32),
                onChanged: (value) => setState(() => _agreed = value ?? false),
              ),
              const Expanded(
                child: Text(
                  'I agree to the Terms and Privacy Policy',
                  style: TextStyle(color: Color(0xFF6A6F5B)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F7D32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Create account',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleButton() {
    return _OutlinedActionButton(
      icon: Icons.g_mobiledata,
      label: 'Sign up with Google',
      onTap: () => _showComingSoon(context),
    );
  }

  Widget _buildPhoneButton() {
    return _OutlinedActionButton(
      icon: Icons.phone_iphone_outlined,
      label: 'Sign up with phone number',
      onTap: () => _showComingSoon(context),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account?',
          style: TextStyle(color: Color(0xFF6A6F5B)),
        ),
        TextButton(
          onPressed: _goToLogin,
          child: const Text(
            'Log in',
            style: TextStyle(
              color: Color(0xFF2F7D32),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void _goToLogin() {
    Navigator.pushReplacementNamed(context, LoginPage.routeName);
  }
}

class _TopBar extends StatelessWidget {
  final String leadingLabel;
  final String trailingLabel;
  final VoidCallback? onLeadingTap;
  final VoidCallback? onTrailingTap;

  const _TopBar({
    required this.leadingLabel,
    required this.trailingLabel,
    this.onLeadingTap,
    this.onTrailingTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          onPressed: onLeadingTap,
          icon: const Icon(Icons.arrow_back_ios_new, size: 16, color: Color(0xFF6A6F5B)),
          label: Text(
            leadingLabel,
            style: const TextStyle(color: Color(0xFF6A6F5B)),
          ),
        ),
        TextButton(
          onPressed: onTrailingTap,
          child: Text(
            trailingLabel,
            style: const TextStyle(color: Color(0xFF6A6F5B)),
          ),
        ),
      ],
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final String hint;
  final String? helperText;
  final TextInputType? keyboardType;

  const _LabeledField({
    required this.label,
    required this.hint,
    this.helperText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF2F2F2F),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            helperText: helperText,
            helperStyle: const TextStyle(color: Color(0xFF9AA187)),
            filled: true,
            fillColor: const Color(0xFFFBF5EC),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _PasswordField extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscure;
  final VoidCallback onToggle;

  const _PasswordField({
    required this.label,
    required this.hint,
    required this.obscure,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF2F2F2F),
              ),
            ),
            const Text(
              'Min. 8 characters',
              style: TextStyle(color: Color(0xFF9AA187), fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFFBF5EC),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: const Color(0xFF9AA187),
              ),
              onPressed: onToggle,
            ),
          ),
        ),
      ],
    );
  }
}

class _OutlinedActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _OutlinedActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF2F2F2F),
          side: const BorderSide(color: Color(0xFFE0E3D2)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          backgroundColor: Colors.white,
        ),
        onPressed: onTap,
        icon: Icon(icon, color: const Color(0xFF2F2F2F)),
        label: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

void _showComingSoon(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Coming soon'),
      content: const Text('This feature is almost ready. Please continue with email for now.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Okay'),
        ),
      ],
    ),
  );
}

