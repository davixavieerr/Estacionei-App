import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/custom_button.dart';

class CondoPassScreen extends StatelessWidget {
  final String buildingName;
  final String address;
  final String hostName;
  final String spotNumber;
  final String vehiclePlate;
  final String vehicleModel;
  final String driverName;

  const CondoPassScreen({
    super.key,
    required this.buildingName,
    required this.address,
    required this.hostName,
    this.spotNumber = 'Vaga 34 (2º Subsolo)',
    this.vehiclePlate = 'BRA-2E19',
    this.vehicleModel = 'Toyota Corolla Preto',
    this.driverName = 'Davi Xavier Miranda',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardSurface,
        title: const Text('Passe de Acesso à Garagem', style: TextStyle(color: AppColors.textPrimary)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryBlue.withValues(alpha: 0.25),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset('assets/images/logo.png', height: 38, width: 38, errorBuilder: (_, __, ___) => const Icon(Icons.apartment, color: Colors.white)),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('AUTORIZAÇÃO DE ENTRADA', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                          Text('ESTACIONEI PASS', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ),
                    const Icon(Icons.verified, color: AppColors.statusGreen, size: 28),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.qr_code_2_rounded, size: 160, color: Colors.black),
                          const SizedBox(height: 6),
                          Text(
                            'TOKEN: ESTAC-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                            style: const TextStyle(color: Colors.black54, fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildPassRow('Condomínio:', buildingName),
                    _buildPassRow('Vaga / Local:', spotNumber),
                    _buildPassRow('Condômino / Anfitrião:', hostName),
                    const Divider(color: Colors.black12, height: 24),
                    _buildPassRow('Motorista:', driverName),
                    _buildPassRow('Veículo:', vehicleModel),
                    _buildPassRow('Placa Autorizada:', vehiclePlate, isHighlighted: true),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: 'Liberar Acesso na Guarita',
                      backgroundColor: AppColors.statusGreen,
                      icon: Icons.check_circle_outline,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: AppColors.statusGreen,
                            content: Text('Acesso registrado com sucesso no sistema da portaria!'),
                          ),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPassRow(String label, String value, {bool isHighlighted = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54, fontSize: 12)),
          Text(
            value,
            style: TextStyle(
              color: isHighlighted ? AppColors.primaryBlue : Colors.black87,
              fontSize: 13,
              fontWeight: isHighlighted ? FontWeight.w900 : FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
