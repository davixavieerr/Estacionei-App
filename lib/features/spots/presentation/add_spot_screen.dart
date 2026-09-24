import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/models/parking_spot_model.dart';
import '../../../shared/widgets/custom_button.dart';
import '../data/spots_repository.dart';
import 'location_picker_screen.dart';

class AddSpotScreen extends StatefulWidget {
  final VoidCallback? onSpotAdded;

  const AddSpotScreen({super.key, this.onSpotAdded});

  @override
  State<AddSpotScreen> createState() => _AddSpotScreenState();
}

class _AddSpotScreenState extends State<AddSpotScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _rulesController = TextEditingController();
  final _monthlyPriceController = TextEditingController(text: '450.00');
  final _hourlyPriceController = TextEditingController();

  double _simulatedMonthly = 450.0;
  RentalModality _modality = RentalModality.monthlyOnly;
  VehicleSize _vehicleSize = VehicleSize.sedan;
  AccessMethod _accessMethod = AccessMethod.remoteControl;
  int _minMonths = 3;
  bool _allowsExternalGuests = true;
  bool _hasEVCharger = false;
  bool _isLoading = false;

  LatLng? _selectedLocation;

  Future<LatLng> _geocodeAddress(String address) async {
    try {
      final clean = address.replaceAll(RegExp(r'[nN][ºoO]?\s*'), '');
      final query = Uri.encodeComponent('$clean, São Paulo - SP, Brasil');
      final url = Uri.parse('https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1');

      final response = await http.get(url, headers: {'User-Agent': 'EstacioneiApp/1.0'});

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          final lat = double.parse(data[0]['lat']);
          final lon = double.parse(data[0]['lon']);
          return LatLng(lat, lon);
        }
      }
    } catch (_) {}

    final lower = address.toLowerCase();
    if (lower.contains('oscar porto') || lower.contains('tutoia') || lower.contains('paraiso')) {
      return const LatLng(-23.5732, -46.6508);
    }
    return const LatLng(-23.5614, -46.6558);
  }

  void _openLocationPicker() async {
    final initial = _selectedLocation ??
        await _geocodeAddress(_addressController.text.isEmpty
            ? 'Avenida Paulista'
            : _addressController.text);

    if (!mounted) return;

    final LatLng? picked = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => LocationPickerScreen(initialPosition: initial)),
    );

    if (!mounted) return;

    if (picked != null) {
      setState(() => _selectedLocation = picked);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.statusGreen,
          content: Text('Ponto exato da garagem fixado no mapa!'),
        ),
      );
    }
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final coords = _selectedLocation ?? await _geocodeAddress(_addressController.text.trim());

    final newSpot = ParkingSpot(
      id: 'my_spot_${DateTime.now().millisecondsSinceEpoch}',
      hostId: SpotsRepository.instance.currentUserId,
      buildingName: _nameController.text.trim(),
      address: _addressController.text.trim(),
      latitude: coords.latitude,
      longitude: coords.longitude,
      spotType: SpotType.residential,
      modality: _modality,
      maxVehicleSize: _vehicleSize,
      accessMethod: _accessMethod,
      totalSpots: 1,
      availableSpots: 1,
      pricePerMonth: double.tryParse(_monthlyPriceController.text.replaceAll(',', '.')),
      pricePerHour: double.tryParse(_hourlyPriceController.text.replaceAll(',', '.')),
      minContractMonths: _minMonths,
      hasEVCharger: _hasEVCharger,
      condominiumRules: _rulesController.text.trim(),
      allowsExternalGuests: _allowsExternalGuests,
      rating: 5.0,
      totalReviews: 0,
    );

    SpotsRepository.instance.addSpot(newSpot);

    if (!mounted) return;
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.statusGreen,
        content: Text('Vaga publicada com sucesso no "${newSpot.buildingName}"!'),
      ),
    );

    _nameController.clear();
    _addressController.clear();
    _rulesController.clear();
    _selectedLocation = null;

    if (widget.onSpotAdded != null) {
      widget.onSpotAdded!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardSurface,
        title: const Text('Anunciar Vaga do Condomínio', style: TextStyle(color: AppColors.textPrimary)),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Simulador de Renda Passiva do Morador
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: AppColors.brandGradient,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryBlue.withValues(alpha: 0.35),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(CupertinoIcons.money_dollar_circle_fill, color: Colors.white, size: 24),
                        SizedBox(width: 8),
                        Text(
                          'SIMULADOR DE GANHO ANUAL',
                          style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${Formatters.formatCurrency(_simulatedMonthly * 12)} / ano',
                      style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      'Alugando sua vaga ociosa a ${Formatters.formatCurrency(_simulatedMonthly)}/mês',
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    Slider(
                      value: _simulatedMonthly,
                      min: 250,
                      max: 800,
                      divisions: 11,
                      activeColor: Colors.white,
                      inactiveColor: Colors.white38,
                      onChanged: (val) {
                        setState(() {
                          _simulatedMonthly = val;
                          _monthlyPriceController.text = val.toStringAsFixed(2);
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              _buildTextField(
                controller: _nameController,
                label: 'Nome do seu Condomínio ou Prédio',
                hint: 'Ex: Edifício Paraíso Prime',
                validator: (val) => val!.isEmpty ? 'Informe o nome do condomínio' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _addressController,
                label: 'Endereço Completo (Rua, Número e Bairro)',
                hint: 'Ex: Rua Coronel Oscar Porto, 114 - Paraíso, SP',
                validator: (val) => val!.isEmpty ? 'Informe o endereço da vaga' : null,
              ),
              const SizedBox(height: 8),

              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: _selectedLocation != null ? AppColors.statusGreen : AppColors.primaryBlue,
                  side: BorderSide(color: _selectedLocation != null ? AppColors.statusGreen : AppColors.primaryBlue),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
                icon: Icon(_selectedLocation != null ? Icons.check_circle : Icons.pin_drop_outlined, size: 20),
                label: Text(
                  _selectedLocation != null ? 'Ponto Ajustado no Mapa (Alterar)' : 'Ajustar Ponto Exato no Mapa',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: _openLocationPicker,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _monthlyPriceController,
                label: 'Valor Mensal Desejado (R\$/mês)',
                hint: 'Ex: 450.00',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (val) => val!.isEmpty ? 'Informe o valor mensal' : null,
              ),
              const SizedBox(height: 16),

              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                activeThumbColor: AppColors.primaryBlue,
                title: const Text('Possui tomada para Carro Elétrico (EV)?', style: TextStyle(color: AppColors.textPrimary, fontSize: 14)),
                subtitle: const Text('Vagas com carregador atraem locatários com valor até 30% maior.', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                value: _hasEVCharger,
                onChanged: (val) => setState(() => _hasEVCharger = val),
              ),
              const SizedBox(height: 12),

              _buildTextField(
                controller: _rulesController,
                label: 'Regras da Portaria e Instruções de Entrada',
                hint: 'Ex: Vaga nº 31 no 2º subsolo. Portaria liberada com CNH e cadastro de placa.',
                maxLines: 3,
                validator: (val) => val!.isEmpty ? 'Informe as instruções de acesso' : null,
              ),
              const SizedBox(height: 24),

              CustomButton(
                text: 'Publicar Vaga no Mapa',
                isLoading: _isLoading,
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
            filled: true,
            fillColor: AppColors.cardSurface,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
