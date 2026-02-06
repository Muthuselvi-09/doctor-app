import 'package:doctor_app/core/theme/revival_colors.dart';
import 'package:flutter/material.dart';

class HospitalUploadCard extends StatefulWidget {
  final String documentName;
  final String description;
  final VoidCallback? onUpload;

  const HospitalUploadCard({
    super.key,
    required this.documentName,
    required this.description,
    this.onUpload,
  });

  @override
  State<HospitalUploadCard> createState() => _HospitalUploadCardState();
}

class _HospitalUploadCardState extends State<HospitalUploadCard> {
  bool _isUploaded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isUploaded ? RevivalColors.success.withOpacity(0.3) : Colors.transparent,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _isUploaded ? RevivalColors.success.withOpacity(0.1) : RevivalColors.accent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              _isUploaded ? Icons.check : Icons.description,
              color: _isUploaded ? RevivalColors.success : RevivalColors.primaryBlue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.documentName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: RevivalColors.navyBlue,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: RevivalColors.darkGrey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _isUploaded
              ? IconButton(
                  onPressed: () {
                    // Remove file
                    setState(() {
                      _isUploaded = false;
                    });
                  },
                  icon: const Icon(Icons.delete_outline, color: RevivalColors.danger),
                )
              : OutlinedButton(
                  onPressed: () {
                    if (widget.onUpload != null) {
                      widget.onUpload!();
                    } else {
                      // Simulate upload if no callback provided
                      setState(() {
                        _isUploaded = true;
                      });
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: RevivalColors.primaryBlue,
                    side: const BorderSide(color: RevivalColors.primaryBlue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text("Upload"),
                ),
        ],
      ),
    );
  }
}
