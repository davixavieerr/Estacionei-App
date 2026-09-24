import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardSurface,
        title: const Text('Suporte e Ajuda', style: TextStyle(color: AppColors.textPrimary)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildFaqItem('Como funciona a entrada na portaria?', 'Ao chegar no condomínio, abra o passe na aba "Reservas" e apresente o QR Code ou nome do anfitrião ao porteiro.'),
          _buildFaqItem('O que fazer se perder o controle da garagem?', 'A plataforma possui uma caução retida no contrato para reposição imediata junto à administração do prédio.'),
          _buildFaqItem('Como recebo o valor se for morador?', 'Os repasses são feitos automaticamente na sua chave Pix no 5º dia útil de cada mês.'),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.statusGreen,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.support_agent_rounded, color: Colors.white),
            label: const Text('Falar com Suporte no WhatsApp', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Canal de suporte Estacionei pronto para conexão.')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem(String q, String a) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ExpansionTile(
        title: Text(q, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13.5)),
        iconColor: AppColors.primaryBlue,
        collapsedIconColor: AppColors.textSecondary,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(a, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          ),
        ],
      ),
    );
  }
}
