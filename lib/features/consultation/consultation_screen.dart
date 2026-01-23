import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/theme/app_colors.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  bool _isVideoOn = true;
  bool _isMuted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Main Video (Doctor)
          _buildDoctorVideo(),
          
          // My Video (Small Overlay)
          _buildMyVideoOverlay(),

          // Top Bar (Controls)
          _buildTopBar(context),

          // Bottom Bar (Actions)
          _buildBottomControls(),
        ],
      ),
    );
  }

  Widget _buildDoctorVideo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[900],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Placeholder for Doctor's Video
          const Icon(Icons.person, size: 200, color: Colors.white24),
          Positioned(
            bottom: 150,
            child: Column(
              children: [
                const Text(
                  'Dr. Sarah Johnson',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('REC 05:24', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyVideoOverlay() {
    return Positioned(
      top: 60,
      right: 20,
      child: FadeInRight(
        child: Container(
          width: 120,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white24, width: 2),
            boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10)],
          ),
          child: const Center(
            child: Icon(Icons.person, color: Colors.white24, size: 40),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Positioned(
      top: 50,
      left: 20,
      child: FadeInLeft(
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: FadeInUp(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildControlItem(
              icon: _isMuted ? Icons.mic_off_rounded : Icons.mic_rounded,
              color: _isMuted ? Colors.red : Colors.white24,
              onTap: () => setState(() => _isMuted = !_isMuted),
            ),
            _buildControlItem(
              icon: Icons.call_end_rounded,
              color: Colors.red,
              size: 70,
              onTap: () => Navigator.pop(context),
            ),
            _buildControlItem(
              icon: _isVideoOn ? Icons.videocam_rounded : Icons.videocam_off_rounded,
              color: _isVideoOn ? Colors.white24 : Colors.red,
              onTap: () => setState(() => _isVideoOn = !_isVideoOn),
            ),
            _buildControlItem(
              icon: Icons.chat_bubble_rounded,
              color: Colors.white24,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlItem({
    required IconData icon,
    required Color color,
    double size = 60,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: size * 0.4),
      ),
    );
  }
}
