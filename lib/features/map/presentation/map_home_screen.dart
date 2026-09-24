import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/constants/map_style.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/models/parking_spot_model.dart';
import '../../spots/data/spots_repository.dart';
import '../../spots/presentation/condo_pass_screen.dart';
import '../../spots/presentation/spot_details_screen.dart';

class MapHomeScreen extends StatefulWidget {
  const MapHomeScreen({super.key});

  @override
  State<MapHomeScreen> createState() => _MapHomeScreenState();
}

class _MapHomeScreenState extends State<MapHomeScreen> {
  GoogleMapController? _mapController;
  ParkingSpot? _selectedSpot;
  int _segmentedFilterIndex = 0; // 0: Todas, 1: Mensal, 2: Avulso, 3: EV Charger
  bool _isHostMode = false;
  bool _showDynamicIslandAlert = true;

  static const LatLng _paulistaCenter = LatLng(-23.561414, -46.655881);
  final DraggableScrollableController _sheetController = DraggableScrollableController();

  BitmapDescriptor _getMarkerHue(SpotAvailabilityStatus status) {
    switch (status) {
      case SpotAvailabilityStatus.available:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case SpotAvailabilityStatus.limited:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
      case SpotAvailabilityStatus.full:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }
  }

  Set<Marker> _buildMarkers(List<ParkingSpot> spots) {
    return spots.where((spot) {
      if (_segmentedFilterIndex == 1) {
        return spot.modality == RentalModality.monthlyOnly || spot.modality == RentalModality.both;
      }
      if (_segmentedFilterIndex == 2) {
        return spot.modality == RentalModality.hourlyOnly || spot.modality == RentalModality.both;
      }
      if (_segmentedFilterIndex == 3) {
        return spot.hasEVCharger;
      }
      return true;
    }).map((spot) {
      return Marker(
        markerId: MarkerId(spot.id),
        position: LatLng(spot.latitude, spot.longitude),
        icon: _getMarkerHue(spot.status),
        infoWindow: InfoWindow(
          title: spot.buildingName,
          snippet: spot.pricePerMonth != null
              ? '${Formatters.formatCurrency(spot.pricePerMonth!)}/mês'
              : '${Formatters.formatCurrency(spot.pricePerHour ?? 0)}/h',
        ),
        onTap: () {
          setState(() => _selectedSpot = spot);
          _mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(LatLng(spot.latitude, spot.longitude), 16.2),
          );
          _sheetController.animateTo(
            0.50,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
          );
        },
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: SpotsRepository.instance,
      builder: (context, _) {
        final spots = SpotsRepository.instance.spots;

        return Scaffold(
          backgroundColor: AppColors.darkBackground,
          body: Stack(
            children: [
              // 1. Google Maps em Tela Cheia Nativa iOS
              GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: _paulistaCenter,
                  zoom: 15.0,
                ),
                style: MapStyle.darkMapJson,
                onMapCreated: (controller) => _mapController = controller,
                markers: _buildMarkers(spots),
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                compassEnabled: false,
                mapToolbarEnabled: false,
                onTap: (_) => setState(() => _selectedSpot = null),
              ),

              // 2. Dynamic Island Superior (iOS 27 Live Activity Header)
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_showDynamicIslandAlert) _buildDynamicIslandPill(),
                      const SizedBox(height: 8),

                      // Barra de Pesquisa Suspensa com Efeito de Vidro Jateado
                      ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.cardSurface.withValues(alpha: 0.85),
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(color: Colors.white12, width: 0.8),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    CupertinoIcons.location_solid,
                                    color: AppColors.primaryBlue,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'ESTACIONEI',
                                            style: TextStyle(
                                              color: AppColors.primaryBlue,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 12,
                                              letterSpacing: 1.1,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                                            decoration: BoxDecoration(
                                              color: AppColors.statusGreen.withValues(alpha: 0.2),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: const Text(
                                              'AO VIVO',
                                              style: TextStyle(
                                                color: AppColors.statusGreen,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 8.5,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        'Paulista, Paraíso e Jardins (SP)',
                                        style: TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    color: Colors.white10,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(CupertinoIcons.search, color: AppColors.primaryBlue, size: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Segmented Control do iOS
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: AppColors.cardSurface.withValues(alpha: 0.8),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white10),
                            ),
                            child: CupertinoSlidingSegmentedControl<int>(
                              backgroundColor: Colors.transparent,
                              thumbColor: AppColors.primaryBlue,
                              groupValue: _segmentedFilterIndex,
                              children: {
                                0: _buildSegmentText('Todas', 0),
                                1: _buildSegmentText('🏢 Mensal', 1),
                                2: _buildSegmentText('⏱️ Horista', 2),
                                3: _buildSegmentText('⚡ Veículo Elétrico', 3),
                              },
                              onValueChanged: (val) {
                                if (val != null) {
                                  setState(() => _segmentedFilterIndex = val);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 3. Apple Maps Draggable Sheet
              DraggableScrollableSheet(
                controller: _sheetController,
                initialChildSize: 0.20,
                minChildSize: 0.12,
                maxChildSize: 0.85,
                snap: true,
                snapSizes: const [0.20, 0.50, 0.85],
                builder: (context, scrollController) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.cardSurface.withValues(alpha: 0.95),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(28),
                          ),
                          border: Border.all(color: Colors.white12, width: 0.8),
                        ),
                        child: ListView(
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          children: [
                            Center(
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                width: 36,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Vagas & Garagens na Região',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.4,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.statusGreen.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${spots.length} ativas',
                                    style: const TextStyle(
                                      color: AppColors.statusGreen,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),

                            if (_selectedSpot != null) ...[
                              _buildSelectedSpotAppleCard(_selectedSpot!),
                              const SizedBox(height: 16),
                            ],

                            ...spots.map((spot) => _buildAppleSpotTile(spot)),
                            const SizedBox(height: 110),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDynamicIslandPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.brandCyan.withValues(alpha: 0.4), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.3),
            blurRadius: 16,
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(CupertinoIcons.car_detailed, color: AppColors.brandCyan, size: 18),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'RESERVA ATIVA: VAGA 34 (G2)',
                  style: TextStyle(color: Colors.white70, fontSize: 9.5, fontWeight: FontWeight.bold, letterSpacing: 0.8),
                ),
                Text(
                  'Ed. Barão de Capanema • Portão Liberado',
                  style: TextStyle(color: Colors.white, fontSize: 11.5, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CondoPassScreen(
                    buildingName: 'Condomínio Barão de Capanema',
                    address: 'Alameda Santos, 1893 - Cerqueira César, SP',
                    hostName: 'Carlos Mendonça',
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text('Abrir Passe', style: TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentText(String label, int index) {
    final isSelected = _segmentedFilterIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          fontSize: 11.5,
        ),
      ),
    );
  }

  Widget _buildSelectedSpotAppleCard(ParkingSpot spot) {
    final isMonthly = spot.pricePerMonth != null;
    final isFull = spot.status == SpotAvailabilityStatus.full;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.5), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                spot.buildingName,
                style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                isMonthly ? '${Formatters.formatCurrency(spot.pricePerMonth!)}/mês' : '${Formatters.formatCurrency(spot.pricePerHour ?? 0)}/h',
                style: const TextStyle(color: AppColors.statusGreen, fontSize: 16, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(spot.address, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  color: isFull ? AppColors.statusRed : AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(14),
                  child: Text(
                    isFull ? 'Entrar na Lista de Espera' : 'Ver Detalhes e Contratar',
                    style: const TextStyle(color: Colors.white, fontSize: 13.5, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SpotDetailsScreen(spot: spot)),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppleSpotTile(ParkingSpot spot) {
    final isMonthly = spot.pricePerMonth != null;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: (spot.spotType == SpotType.residential ? AppColors.primaryBlue : Colors.purple).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            spot.spotType == SpotType.residential ? CupertinoIcons.building_2_fill : CupertinoIcons.car_detailed,
            color: spot.spotType == SpotType.residential ? AppColors.primaryBlue : Colors.purpleAccent,
            size: 20,
          ),
        ),
        title: Text(
          spot.buildingName,
          style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          spot.address,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 11.5),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              isMonthly ? '${Formatters.formatCurrency(spot.pricePerMonth!)}/m' : '${Formatters.formatCurrency(spot.pricePerHour ?? 0)}/h',
              style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700, fontSize: 13),
            ),
            Text(
              spot.availableSpots > 0 ? 'Disponível' : 'Lotado',
              style: TextStyle(
                color: spot.availableSpots > 0 ? AppColors.statusGreen : AppColors.statusRed,
                fontSize: 10.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        onTap: () {
          setState(() => _selectedSpot = spot);
          _mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(LatLng(spot.latitude, spot.longitude), 16.5),
          );
        },
      ),
    );
  }
}
