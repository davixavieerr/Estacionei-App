import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/models/parking_spot_model.dart';

class SpotDetailsCard extends StatelessWidget {
  final ParkingSpot spot;
  final VoidCallback onReserve;
  final VoidCallback onWaitlist;
  final VoidCallback? onClose;

  const SpotDetailsCard({
    super.key,
    required this.spot,
    required this.onReserve,
    required this.onWaitlist,
    this.onClose,
  });

  Color _getStatusColor(SpotAvailabilityStatus status) {
    switch (status) {
      case SpotAvailabilityStatus.available:
        return AppColors.statusGreen;
      case SpotAvailabilityStatus.limited:
        return AppColors.statusAmber;
      case SpotAvailabilityStatus.full:
        return AppColors.statusRed;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFull = spot.status == SpotAvailabilityStatus.full;
    final statusColor = _getStatusColor(spot.status);
    final isMonthly = spot.pricePerMonth != null;
    final isResidential = spot.spotType == SpotType.residential;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: statusColor.withValues(alpha: 0.35), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.55),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              color: isResidential
                  ? AppColors.primaryBlue.withValues(alpha: 0.15)
                  : Colors.purple.withValues(alpha: 0.15),
              child: Row(
                children: [
                  Icon(
                    isResidential ? Icons.apartment_rounded : Icons.business_rounded,
                    size: 16,
                    color: isResidential ? AppColors.primaryBlue : Colors.purpleAccent,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isResidential
                        ? 'CONDOMÍNIO RESIDENCIAL • MORADOR P2P'
                        : 'ESTACIONAMENTO COMERCIAL • REDE HOMOLOGADA',
                    style: TextStyle(
                      color: isResidential ? AppColors.primaryBlue : Colors.purpleAccent,
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: statusColor, width: 1),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(radius: 3.5, backgroundColor: statusColor),
                        const SizedBox(width: 5),
                        Text(
                          isFull ? 'Lotado' : (isMonthly ? 'Vaga Cativa' : '${spot.availableSpots} vagas'),
                          style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    spot.buildingName,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(Icons.place_outlined, color: AppColors.textSecondary, size: 14),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          spot.address,
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.cardSurfaceLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.shield_outlined, color: AppColors.statusGreen, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            spot.condominiumRules,
                            style: const TextStyle(color: AppColors.textSecondary, fontSize: 11.5),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isMonthly ? 'Contrato Mensal' : 'Valor da Hora',
                            style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
                          ),
                          Text(
                            isMonthly
                                ? '${Formatters.formatCurrency(spot.pricePerMonth!)}/mês'
                                : '${Formatters.formatCurrency(spot.pricePerHour ?? 0)}/h',
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            '${spot.rating} (${spot.totalReviews})',
                            style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isFull ? AppColors.statusRed : AppColors.primaryBlue,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: isFull ? onWaitlist : onReserve,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isFull
                                ? Icons.notifications_active_outlined
                                : (isMonthly ? Icons.description_outlined : Icons.directions_car_rounded),
                            color: Colors.white,
                            size: 19,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isFull
                                ? 'Entrar na Lista de Espera (Alerta)'
                                : (isMonthly ? 'Ver Termos e Contratar Vaga' : 'Reservar Vaga Agora'),
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
