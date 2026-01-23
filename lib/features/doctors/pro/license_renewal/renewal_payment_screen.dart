import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class RenewalPaymentScreen extends StatefulWidget {
  const RenewalPaymentScreen({super.key});

  @override
  State<RenewalPaymentScreen> createState() => _RenewalPaymentScreenState();
}

class _RenewalPaymentScreenState extends State<RenewalPaymentScreen> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text('License Fee Payment'),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildGlassAmountCard(),
            const SizedBox(height: 32),
            _buildPaymentMethods(),
            const SizedBox(height: 48),
            _buildPayButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassAmountCard() {
    return FadeInDown(
      child: Container(
        padding: const EdgeInsets.all(32),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white.withOpacity(0.5)),
        ),
        child: Column(
          children: [
             const Text('Total Renewal Fee', style: TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.bold)),
             const SizedBox(height: 8),
             const Text('₹12,500.00', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
             const SizedBox(height: 16),
             Container(
               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
               decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
               child: const Row(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   Icon(Icons.security_rounded, color: Colors.blue, size: 14),
                   SizedBox(width: 6),
                   Text('Bank Grade Security', style: TextStyle(color: Colors.blue, fontSize: 10, fontWeight: FontWeight.bold)),
                 ],
               ),
             ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    final methods = [
       {'name': 'Credit / Debit Card', 'icon': Icons.credit_card_rounded},
       {'name': 'UPI ID (Google Pay / PhonePe)', 'icon': Icons.account_balance_wallet_rounded},
       {'name': 'Net Banking', 'icon': Icons.account_balance_rounded},
    ];

    return Column(
      children: methods.map((m) => FadeInUp(
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Row(
            children: [
               Icon(m['icon'] as IconData, color: AppColors.primary),
               const SizedBox(width: 16),
               Text(m['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
               const Spacer(),
               const Icon(Icons.radio_button_off_rounded, color: AppColors.textHint),
            ],
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildPayButton() {
    return ElevatedButton(
      onPressed: () async {
        setState(() => _isProcessing = true);
        await Future.delayed(const Duration(seconds: 3));
        if (mounted) {
          context.push('/renewal-tracking');
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 64),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: _isProcessing 
        ? const CircularProgressIndicator(color: Colors.white)
        : const Text('Pay Now & Submit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
