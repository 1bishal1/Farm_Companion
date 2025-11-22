import 'package:farm/screens/farm_companion_onboarding.dart';
import 'package:farm/screens/signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  bool _rememberDevice = false;

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
              _TopRow(
                onBack: _goToOnboarding,
                trailingLabel: 'Help',
                onHelp: () => _showComingSoon(context),
              ),
              const SizedBox(height: 16),
              const Text(
                'Log in to your farm',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2C1C),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Access your animals, tasks, and health insights in one place.',
                style: TextStyle(
                  color: Color(0xFF6A6F5B),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              _buildForm(),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'or continue with',
                  style: TextStyle(color: Color(0xFF9AA187)),
                ),
              ),
              const SizedBox(height: 12),
              _OutlinedActionButton(
                icon: Icons.g_mobiledata,
                label: 'Log in with Google',
                onTap: () => _showComingSoon(context),
              ),
              const SizedBox(height: 12),
              _OutlinedActionButton(
                icon: Icons.phone_android_outlined,
                label: 'Log in with phone number',
                onTap: () => _showComingSoon(context),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'New to Farm Companion?',
                    style: TextStyle(color: Color(0xFF6A6F5B)),
                  ),
                  TextButton(
                    onPressed: _goToSignup,
                    child: const Text(
                      'Create an account',
                      style: TextStyle(
                        color: Color(0xFF2F7D32),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
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
        children: [
          _LabeledField(
            label: 'Email or phone',
            hint: 'name@farm.com or +254...',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          _PasswordField(
            label: 'Password',
            hint: 'Enter your password',
            obscure: _obscurePassword,
            onToggle: () => setState(() => _obscurePassword = !_obscurePassword),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Checkbox(
                value: _rememberDevice,
                activeColor: const Color(0xFF2F7D32),
                onChanged: (value) => setState(() => _rememberDevice = value ?? false),
              ),
              const Expanded(
                child: Text(
                  'Remember this device',
                  style: TextStyle(color: Color(0xFF6A6F5B)),
                ),
              ),
              TextButton(
                onPressed: () => _showComingSoon(context),
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(color: Color(0xFF2F7D32)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
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
                'Log in',
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

  void _goToOnboarding() {
    Navigator.pushReplacementNamed(context, FarmCompanionOnboarding.routeName);
  }

  void _goToSignup() {
    Navigator.pushReplacementNamed(context, SignupPage.routeName);
  }
}

class _TopRow extends StatelessWidget {
  final VoidCallback onBack;
  final String trailingLabel;
  final VoidCallback? onHelp;

  const _TopRow({
    required this.onBack,
    required this.trailingLabel,
    this.onHelp,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back_ios_new, size: 16, color: Color(0xFF6A6F5B)),
          label: const Text(
            'Back',
            style: TextStyle(color: Color(0xFF6A6F5B)),
          ),
        ),
        TextButton(
          onPressed: onHelp,
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
  final TextInputType? keyboardType;

  const _LabeledField({
    required this.label,
    required this.hint,
    this.keyboardType,
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
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
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
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
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
      content: const Text('This option will be available shortly. Please continue with email for now.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Okay'),
        ),
      ],
    ),
  );
}

