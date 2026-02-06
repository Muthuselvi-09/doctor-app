import 'package:flutter/material.dart';

class HospitalLicenseConfig {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final List<String> requiredDocuments;

  const HospitalLicenseConfig({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.requiredDocuments,
  });
}
