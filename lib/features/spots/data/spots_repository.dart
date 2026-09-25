import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../shared/models/parking_spot_model.dart';

class SpotsRepository extends ChangeNotifier {
  static final SpotsRepository instance = SpotsRepository._internal();
  SpotsRepository._internal() {
    fetchSpots();
  }

  final String currentUserId = 'host_me';

  // Configuração Oficial do seu Supabase
  static const String supabaseUrl = 'https://ugiudafctzdyjtrrmskb.supabase.co';
  static const String supabaseKey =
      'sb_publishable_81Jtp1TVMBjzmRDSDBx-4Q_hU2UYPp7';

  List<ParkingSpot> _spots = [
    const ParkingSpot(
      id: 'sp_mensal_01',
      hostId: 'host_01',
      buildingName: 'Condomínio Barão de Capanema',
      address: 'Alameda Santos, 1893 - Cerqueira César, SP',
      latitude: -23.560100,
      longitude: -46.658200,
      spotType: SpotType.residential,
      modality: RentalModality.monthlyOnly,
      maxVehicleSize: VehicleSize.suv,
      accessMethod: AccessMethod.remoteControl,
      totalSpots: 2,
      availableSpots: 1,
      pricePerMonth: 420.00,
      minContractMonths: 3,
      hasEVCharger: true,
      condominiumRules:
          'Morador com 2 vagas alugando 1 vaga livre. Entrega de tag/controle e autorização com o síndico.',
      allowsExternalGuests: true,
      rating: 5.0,
      totalReviews: 14,
    ),
    const ParkingSpot(
      id: 'sp_mensal_02',
      hostId: 'host_02',
      buildingName: 'Edifício Residencial Anchieta',
      address: 'Av. Paulista, 2584 - Consolação, SP',
      latitude: -23.556200,
      longitude: -46.662500,
      spotType: SpotType.residential,
      modality: RentalModality.monthlyOnly,
      maxVehicleSize: VehicleSize.sedan,
      accessMethod: AccessMethod.qrCode,
      totalSpots: 1,
      availableSpots: 1,
      pricePerMonth: 380.00,
      minContractMonths: 1,
      hasEVCharger: false,
      condominiumRules:
          'Vaga demarcada no 2º subsolo com cancela eletrônica por QR Code do Estacionei.',
      allowsExternalGuests: true,
      rating: 4.9,
      totalReviews: 9,
    ),
    const ParkingSpot(
      id: 'sp_mensal_03',
      hostId: 'host_03',
      buildingName: 'Condomínio Parque Paulista',
      address: 'Rua Cincinato Braga, 450 - Bela Vista, SP',
      latitude: -23.568400,
      longitude: -46.647800,
      spotType: SpotType.residential,
      modality: RentalModality.monthlyOnly,
      maxVehicleSize: VehicleSize.compact,
      accessMethod: AccessMethod.conciergeList,
      totalSpots: 1,
      availableSpots: 0,
      pricePerMonth: 350.00,
      minContractMonths: 6,
      hasEVCharger: false,
      condominiumRules:
          'Vaga atualmente ocupada. Ative a Fila de Espera para ser notificado assim que desocupar.',
      allowsExternalGuests: true,
      rating: 4.8,
      totalReviews: 21,
    ),
    const ParkingSpot(
      id: 'sp_rotativo_01',
      hostId: 'host_04',
      buildingName: 'Estacionamento Top Center (Comercial)',
      address: 'Av. Paulista, 854 - Bela Vista, SP',
      latitude: -23.565800,
      longitude: -46.651500,
      spotType: SpotType.commercial,
      modality: RentalModality.both,
      maxVehicleSize: VehicleSize.sedan,
      accessMethod: AccessMethod.conciergeList,
      totalSpots: 10,
      availableSpots: 3,
      pricePerHour: 22.00,
      pricePerMonth: 650.00,
      minContractMonths: 1,
      hasEVCharger: true,
      condominiumRules:
          'Rede comercial com seguro total, manobrista e opção de mensalista com nota fiscal.',
      allowsExternalGuests: true,
      rating: 4.7,
      totalReviews: 142,
    ),
  ];

  List<ParkingSpot> get spots => List.unmodifiable(_spots);
  List<ParkingSpot> get mySpots =>
      _spots.where((s) => s.hostId == currentUserId).toList();

  /// Busca as vagas reais no Supabase via REST API
  Future<void> fetchSpots() async {
    try {
      final url = Uri.parse('$supabaseUrl/rest/v1/parking_spots?select=*');
      final response = await http.get(
        url,
        headers: {
          'apikey': supabaseKey,
          'Authorization': 'Bearer $supabaseKey',
        },
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          _spots = data
              .map((e) => ParkingSpot.fromMap(e as Map<String, dynamic>))
              .toList();
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint('Erro ao carregar dados do Supabase: $e');
    }
  }

  /// Adiciona nova vaga e sincroniza com o Supabase
  Future<void> addSpot(ParkingSpot spot) async {
    _spots.insert(0, spot);
    notifyListeners();

    try {
      final url = Uri.parse('$supabaseUrl/rest/v1/parking_spots');
      await http.post(
        url,
        headers: {
          'apikey': supabaseKey,
          'Authorization': 'Bearer $supabaseKey',
          'Content-Type': 'application/json',
          'Prefer': 'return=minimal',
        },
        body: jsonEncode(spot.toMap()),
      );
    } catch (e) {
      debugPrint('Erro ao salvar vaga no Supabase: $e');
    }
  }

  void removeSpot(String id) {
    _spots.removeWhere((s) => s.id == id);
    notifyListeners();
  }
}
