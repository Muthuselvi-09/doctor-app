import 'package:flutter/material.dart';

class PharmacyLicenseConfig {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final List<String> requiredDocuments;

  const PharmacyLicenseConfig({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.requiredDocuments,
  });
}
