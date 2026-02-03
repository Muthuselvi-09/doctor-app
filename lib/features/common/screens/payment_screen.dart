import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_app/core/theme/revival_colors.dart';

class PaymentScreen extends StatefulWidget {
  final String? invoiceId;

  const PaymentScreen({super.key, this.invoiceId});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Checkout', style: GoogleFonts.outfit(color: RevivalColors.deepNavy, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: RevivalColors.deepNavy),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderSummary(),
            const SizedBox(height: 32),
            Text('Payment Method', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: RevivalColors.deepNavy)),
            const SizedBox(height: 16),
            _buildPaymentMethodTile('Credit Card', Icons.credit_card, true),
            _buildPaymentMethodTile('PayPal', Icons.paypal, false),
            _buildPaymentMethodTile('Apple Pay', Icons.apple, false),
            
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: RevivalColors.activeGreen,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: _isProcessing 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text('Pay \$150.00', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: RevivalColors.softGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text('Invoice ID', style: GoogleFonts.outfit(color: RevivalColors.darkGrey)),
               Text(widget.invoiceId ?? 'INV-UNKNOWN', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text('Service', style: GoogleFonts.outfit(color: RevivalColors.darkGrey)),
               Text('License Renewal Fee', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
            ],
          ),
          const Divider(height: 32),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text('Total', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold)),
               Text('\$150.00', style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: RevivalColors.deepNavy)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodTile(String name, IconData icon, bool selected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: selected ? RevivalColors.activeGreen : Colors.grey.shade300, width: selected ? 2 : 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: RevivalColors.navyBlue),
          const SizedBox(width: 16),
          Text(name, style: GoogleFonts.outfit(fontWeight: FontWeight.w500)),
          const Spacer(),
          if (selected) const Icon(Icons.check_circle, color: RevivalColors.activeGreen),
        ],
      ),
    );
  }

  Future<void> _processPayment() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: RevivalColors.activeGreen, size: 64),
              const SizedBox(height: 16),
              Text('Payment Successful!', style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Your transaction ID is TXN-${DateTime.now().millisecondsSinceEpoch}', textAlign: TextAlign.center, style: GoogleFonts.outfit(color: Colors.grey)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                   context.pop(); // Dialog
                   context.pop(); // Screen
                },
                child: const Text('Done'),
              ),
            ],
          ),
        ),
      );
    }
  }
}
