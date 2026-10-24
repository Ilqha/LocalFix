
import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _selectedRole = 'Customer';
  bool _isLogin = true;
  bool _obscurePassword = true;

  static const navy = Color(0xFF12345A);
  static const blue = Color(0xFF1769D2);
  static const background = Color(0xFFE5F4FA);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _continueToApp() {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email and password.'),
        ),
      );
      return;
    }

    if (_selectedRole == 'Customer') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const ProviderDashboard(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/localfix_logo.png',
                      height: 125,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.home_repair_service,
                          size: 75,
                          color: blue,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    _isLogin ? 'Welcome back!' : 'Create your account',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: navy,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _isLogin
                        ? 'Sign in to continue to LocalFix.'
                        : 'Join LocalFix to get started.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF526A86),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'I want to use LocalFix as a:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: navy,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _roleCard(
                          title: 'Customer',
                          subtitle: 'Find services',
                          icon: Icons.person_outline,
                          selected: _selectedRole == 'Customer',
                          onTap: () => setState(
                            () => _selectedRole = 'Customer',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _roleCard(
                          title: 'Service Provider',
                          subtitle: 'Offer services',
                          icon: Icons.handyman_outlined,
                          selected: _selectedRole == 'Service Provider',
                          onTap: () => setState(
                            () => _selectedRole = 'Service Provider',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: blue,
                      ),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.95),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: Color(0xFFC5DDF8),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: Color(0xFFC5DDF8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: blue,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.95),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: Color(0xFFC5DDF8),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: Color(0xFFC5DDF8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _continueToApp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        _isLogin ? 'Sign In' : 'Create Account',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => setState(
                      () => _isLogin = !_isLogin,
                    ),
                    child: Text(
                      _isLogin
                          ? 'New to LocalFix? Create an account'
                          : 'Already have an account? Sign in',
                      style: const TextStyle(color: blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _roleCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 6,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFD7EAFE)
              : Colors.white.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? blue : const Color(0xFFC5DDF8),
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: blue),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: navy,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF526A86),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProviderDashboard extends StatelessWidget {
  const ProviderDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F4FA),
      appBar: AppBar(
        title: const Text('Provider Dashboard'),
        backgroundColor: const Color(0xFF12345A),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.handyman,
                size: 64,
                color: Color(0xFF1769D2),
              ),
              SizedBox(height: 16),
              Text(
                'Welcome, Service Provider!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF12345A),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Your provider dashboard will be developed next.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}