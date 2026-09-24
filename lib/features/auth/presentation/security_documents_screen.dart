import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SecurityDocumentsScreen extends StatelessWidget {
  const SecurityDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardSurface,
        title: const Text('Segurança e Documentos', style: TextStyle(color: AppColors.textPrimary)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildDocItem('CNH do Motorista', 'Validada pelo Detran/SP', Icons.badge_outlined, true),
          _buildDocItem('CRLV do Veículo (Placa)', 'Toyota Corolla - Regular', Icons.directions_car_outlined, true),
          _buildDocItem('Comprovante de Residência', 'Para cadastro em condomínios', Icons.home_work_outlined, true),
          _buildDocItem('Termo de Condomínio Assinado', 'Conformidade com a Convenção', Icons.gavel_outlined, true),
        ],
      ),
    );
  }

  Widget _buildDocItem(String title, String desc, IconData icon, bool verified) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryBlue, size: 26),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
                Text(desc, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Icon(verified ? Icons.check_circle : Icons.pending, color: verified ? AppColors.statusGreen : AppColors.statusAmber),
        ],
      ),
    );
  }
}
