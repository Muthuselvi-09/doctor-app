import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/revival_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.go('/role-selection'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: RevivalColors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: RevivalColors.navyBlue.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.medical_services_rounded,
                    color: RevivalColors.navyBlue,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              FadeInLeft(
                child: Text(
                  'Welcome Back!',
                  style: GoogleFonts.outfit(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: RevivalColors.deepNavy,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              FadeInLeft(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  'Sign in to manage your medical compliance and licensing.',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    color: RevivalColors.darkGrey,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // Login Tabs
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: RevivalColors.midGrey),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: RevivalColors.navyBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: RevivalColors.darkGrey,
                    labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                    tabs: const [
                      Tab(text: 'Mobile Number'),
                      Tab(text: 'Email Address'),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // To handle Tab View content properly in column without expanded
              SizedBox(
                height: 300, 
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Mobile Login
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      child: Column(
                        children: [
                          TextField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'Mobile Number',
                              prefixIcon: const Icon(Icons.phone_iphone_rounded),
                              prefixText: '+91 ',
                              prefixStyle: GoogleFonts.outfit(
                                color: RevivalColors.deepNavy,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () => context.go('/portal-selection'),
                            child: const Text('Get OTP'),
                          ),
                        ],
                      ),
                    ),
                    
                    // Email Login
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      child: Column(
                        children: [
                          const TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email address',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                  color: RevivalColors.verificationGrey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot Password?',
                                style: GoogleFonts.outfit(
                                  color: RevivalColors.primaryBlue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => context.go('/revival-portal-selection'),
                            child: const Text('Sign In'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              FadeInUp(
                delay: const Duration(milliseconds: 800),
                child: Row(
                  children: [
                    Expanded(child: Divider(color: RevivalColors.midGrey)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Or connect with',
                        style: GoogleFonts.outfit(color: RevivalColors.verificationGrey),
                      ),
                    ),
                    Expanded(child: Divider(color: RevivalColors.midGrey)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              FadeInUp(
                delay: const Duration(milliseconds: 900),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialButton(icon: Icons.g_mobiledata_rounded, onTap: () {}),
                    const SizedBox(width: 20),
                    _SocialButton(icon: Icons.apple, onTap: () {}),
                    const SizedBox(width: 20),
                    _SocialButton(icon: Icons.facebook, onTap: () {}),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              FadeInUp(
                delay: const Duration(milliseconds: 1000),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.outfit(color: RevivalColors.darkGrey),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          color: RevivalColors.navyBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: RevivalColors.midGrey),
        ),
        child: Icon(icon, size: 32, color: RevivalColors.navyBlue),
      ),
    );
  }
}
