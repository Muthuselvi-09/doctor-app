import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class PracticePaymentScreen extends StatelessWidget {
  const PracticePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text('Establishment Renewal Payment'),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildAmountCard(),
            const SizedBox(height: 32),
            _buildSectionTitle('Choose Payment Method'),
            const SizedBox(height: 16),
            _buildPaymentMethods(),
            const SizedBox(height: 48),
            _buildSecureInfo(),
            const SizedBox(height: 48),
            _buildPayButton(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountCard() {
    return FadeInDown(
      child: Container(
        padding: const EdgeInsets.all(32),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(32),
          gradient: const LinearGradient(
            colors: [Color(0xFF0E6EFF), Color(0xFF0056D2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        child: Column(
          children: [
            const Text('Total Renewal Fee', style: TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 8),
            const Text(
              '₹25,000.00',
              style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
              child: const Text('Validity: 5 Years', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: FadeInLeft(
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    final methods = [
      {'name': 'UPI (PhonePe/GPay)', 'icon': Icons.account_balance_wallet_rounded, 'subtitle': 'Instant Verification'},
      {'name': 'Credit / Debit Card', 'icon': Icons.credit_card_rounded, 'subtitle': 'Visa, Mastercard, RuPay'},
      {'name': 'Net Banking', 'icon': Icons.account_balance_rounded, 'subtitle': 'All major Indian banks'},
      {'name': 'Establishment Wallet', 'icon': Icons.wallet_membership_rounded, 'subtitle': 'Balance: ₹12,400'},
    ];

    return Column(
      children: methods.asMap().entries.map((entry) {
        int idx = entry.key;
        var method = entry.value;
        return FadeInUp(
          delay: Duration(milliseconds: 100 * idx),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.5)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle),
                  child: Icon(method['icon'] as IconData, color: AppColors.primary, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(method['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      Text(method['subtitle'] as String, style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSecureInfo() {
    return FadeIn(
      delay: const Duration(milliseconds: 600),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.security_rounded, color: Colors.green[700], size: 16),
          const SizedBox(width: 8),
          Text(
            'Bank-grade 256-bit SSL Secure Payment',
            style: TextStyle(color: Colors.green[700], fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildPayButton(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 800),
      child: ElevatedButton(
        onPressed: () {
          _showProcessingDialog(context);
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 64),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 8,
          shadowColor: AppColors.primary.withOpacity(0.4),
        ),
        child: const Text('Pay ₹25,000.00 Now', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _showProcessingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary)),
              const SizedBox(height: 24),
              const Text('Processing Payment...', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 8),
              Text('Securing connection with bank server', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ],
          ),
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close dialog
      context.push('/practice-inspection');
    });
  }
}
