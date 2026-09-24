import 'package:flutter/material.dart';

class AppColors {
  // Paleta Oficial Estacionei (Cobalt & Cyan Neon)
  static const Color primaryBlue = Color(0xFF1E6EE8);
  static const Color brandBlue = Color(0xFF1E6EE8);
  static const Color brandCyan = Color(0xFF00D4FF);
  static const Color brandIndigo = Color(0xFF123485);

  // Gradiente Estilo Apple iOS 
  static const LinearGradient brandGradient = LinearGradient(
    colors: [Color(0xFF1E6EE8), Color(0xFF00D4FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient appleDarkCard = LinearGradient(
    colors: [Color(0xF2152244), Color(0xF20B132B)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Superfícies e Vidros (Frosted Glass iOS)
  static const Color darkBackground = Color(0xFF070C1A);
  static const Color spaceNavy = Color(0xFF070C1A);
  static const Color cardSurface = Color(0xFF132247);
  static const Color cardSurfaceLight = Color(0xFF1C2C55);
  static const Color glassSurface = Color(0xD90E1933);
  static const Color glassCard = Color(0xF0132247);
  static const Color glassBorder = Color(0x3D4C8DF5);
  static const Color glassHighlight = Color(0x24FFFFFF);

  // Cores Arquitetônicas da Logo
  static const Color creamWhite = Color(0xFFF8F6F0);
  static const Color architecturalGrid = Color(0xFFE8E4D8);

  // Status de Garagem
  static const Color statusGreen = Color(0xFF00E676);
  static const Color statusAmber = Color(0xFFFFB300);
  static const Color statusYellow = Color(0xFFFFB300);
  static const Color statusRed = Color(0xFFFF3D00);

  // Tipografia iOS
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textHero = Color(0xFFFFFFFF);
  static const Color textBody = Color(0xFFCBD5E1);
  static const Color textMuted = Color(0xFF64748B);
}
