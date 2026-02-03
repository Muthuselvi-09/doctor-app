import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_app/core/theme/revival_colors.dart';

class InvoiceListScreen extends StatelessWidget {
  const InvoiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        title: Text('Invoices & Payments', style: GoogleFonts.outfit(color: RevivalColors.deepNavy, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: RevivalColors.deepNavy),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 4,
        itemBuilder: (context, index) {
          return _buildInvoiceCard(context, index);
        },
      ),
    );
  }

  Widget _buildInvoiceCard(BuildContext context, int index) {
    final status = index == 0 ? 'Pending' : 'Paid';
    final color = index == 0 ? Colors.orange : Colors.green;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('INV-2024-${100 + index}', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('Order #ORD-${500 + index}', style: GoogleFonts.outfit(color: RevivalColors.darkGrey, fontSize: 12)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Text(status, style: GoogleFonts.outfit(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Amount', style: GoogleFonts.outfit(color: RevivalColors.darkGrey, fontSize: 12)),
                  Text('\$150.00', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18, color: RevivalColors.deepNavy)),
                ],
              ),
              if (status == 'Pending')
                ElevatedButton(
                  onPressed: () => context.push('/payment', extra: 'INV-2024-${100 + index}'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RevivalColors.navyBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Pay Now'),
                )
              else
                 OutlinedButton(
                  onPressed: () {},
                  child: const Text('Download'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
