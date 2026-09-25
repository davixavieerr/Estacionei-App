enum SpotType { residential, commercial }
enum VehicleSize { compact, sedan, suv, motorcycle }
enum AccessMethod { qrCode, remoteControl, conciergeList }
enum RentalModality { monthlyOnly, hourlyOnly, both }

enum SpotAvailabilityStatus { available, limited, full }

class ParkingSpot {
  final String id;
  final String hostId;
  final String buildingName;
  final String address;
  final double latitude;
  final double longitude;
  final SpotType spotType;
  final RentalModality modality;
  final VehicleSize maxVehicleSize;
  final AccessMethod accessMethod;
  final int totalSpots;
  final int availableSpots;
  final double? pricePerHour;
  final double? pricePerMonth;
  final int minContractMonths;
  final String condominiumRules;
  final bool allowsExternalGuests;
  final bool hasEVCharger;
  final double rating;
  final int totalReviews;
  final List<String> photos;

  const ParkingSpot({
    required this.id,
    required this.hostId,
    required this.buildingName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.spotType,
    required this.modality,
    required this.maxVehicleSize,
    required this.accessMethod,
    required this.totalSpots,
    required this.availableSpots,
    this.pricePerHour,
    this.pricePerMonth,
    this.minContractMonths = 1,
    required this.condominiumRules,
    required this.allowsExternalGuests,
    this.hasEVCharger = false,
    this.rating = 5.0,
    this.totalReviews = 0,
    this.photos = const [],
  });

  SpotAvailabilityStatus get status {
    if (availableSpots == 0) return SpotAvailabilityStatus.full;
    if (availableSpots <= 2) return SpotAvailabilityStatus.limited;
    return SpotAvailabilityStatus.available;
  }

  factory ParkingSpot.fromMap(Map<String, dynamic> map) {
    return ParkingSpot(
      id: map['id']?.toString() ?? '',
      hostId: map['host_id']?.toString() ?? 'host_01',
      buildingName: map['building_name']?.toString() ?? 'Vaga',
      address: map['address']?.toString() ?? '',
      latitude: (map['latitude'] as num?)?.toDouble() ?? -23.5614,
      longitude: (map['longitude'] as num?)?.toDouble() ?? -46.6558,
      spotType: (map['spot_type'] == 'commercial') ? SpotType.commercial : SpotType.residential,
      modality: (map['modality'] == 'both')
          ? RentalModality.both
          : (map['modality'] == 'hourlyOnly')
              ? RentalModality.hourlyOnly
              : RentalModality.monthlyOnly,
      maxVehicleSize: VehicleSize.sedan,
      accessMethod: AccessMethod.qrCode,
      totalSpots: (map['total_spots'] as num?)?.toInt() ?? 1,
      availableSpots: (map['available_spots'] as num?)?.toInt() ?? 1,
      pricePerHour: (map['price_per_hour'] as num?)?.toDouble(),
      pricePerMonth: (map['price_per_month'] as num?)?.toDouble(),
      minContractMonths: (map['min_contract_months'] as num?)?.toInt() ?? 1,
      condominiumRules: map['condominium_rules']?.toString() ?? '',
      allowsExternalGuests: true,
      hasEVCharger: map['has_ev_charger'] == true,
      rating: (map['rating'] as num?)?.toDouble() ?? 5.0,
      totalReviews: (map['total_reviews'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'host_id': hostId,
      'building_name': buildingName,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'spot_type': spotType == SpotType.commercial ? 'commercial' : 'residential',
      'modality': modality == RentalModality.both
          ? 'both'
          : modality == RentalModality.hourlyOnly
              ? 'hourlyOnly'
              : 'monthlyOnly',
      'total_spots': totalSpots,
      'available_spots': availableSpots,
      'price_per_month': pricePerMonth,
      'price_per_hour': pricePerHour,
      'min_contract_months': minContractMonths,
      'has_ev_charger': hasEVCharger,
      'condominium_rules': condominiumRules,
    };
  }
}