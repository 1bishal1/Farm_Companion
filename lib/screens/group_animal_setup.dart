import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GroupAnimalSetupPage extends StatefulWidget {
  static const routeName = '/group-animal-setup';
  final String animalType;

  const GroupAnimalSetupPage({super.key, required this.animalType});

  @override
  State<GroupAnimalSetupPage> createState() => _GroupAnimalSetupPageState();
}

class _GroupAnimalSetupPageState extends State<GroupAnimalSetupPage> {
  final _numberController = TextEditingController();
  String _selectedPurpose = '';

  // State for calculated recommendations
  double _shelterArea = 0;
  double _waterPerDay = 0;
  int _monthlyCost = 0;

  // Define purpose options for each animal
  final Map<String, List<String>> _purposeOptions = {
    'Cow': ['Dairy', 'Meat', 'Breeding', 'Mixed'],
    'Goat': ['Dairy', 'Meat', 'Breeding', 'Mixed'],
    'Buffalo': ['Dairy', 'Meat', 'Breeding', 'Mixed'],
    'Chicken': ['Eggs', 'Meat', 'Breeding', 'Mixed'],
    'Pig': ['Meat', 'Breeding', 'Mixed'],
    'Other': ['Mixed'],
  };

  @override
  void initState() {
    super.initState();
    // Set default purpose
    _selectedPurpose = (_purposeOptions[widget.animalType] ?? ['Mixed']).first;
    _numberController.addListener(_calculateRecommendations);
  }

  @override
  void dispose() {
    _numberController.removeListener(_calculateRecommendations);
    _numberController.dispose();
    super.dispose();
  }

  void _calculateRecommendations() {
    final int numAnimals = int.tryParse(_numberController.text) ?? 0;

    if (numAnimals <= 0) {
      setState(() {
        _shelterArea = 0;
        _waterPerDay = 0;
        _monthlyCost = 0;
      });
      return;
    }

    // Base values for recommendations (per animal)
    double shelterPerAnimal = 0;
    double waterPerAnimal = 0;
    int costPerAnimal = 0;

    // Logic for Cow and Goat as requested
    switch (widget.animalType) {
      case 'Cow':
        shelterPerAnimal = 10; // m^2
        waterPerAnimal = 65; // Liters
        costPerAnimal = 35000; // NPR
        break;
      case 'Goat':
        shelterPerAnimal = 2; // m^2
        waterPerAnimal = 10; // Liters
        costPerAnimal = 7000; // NPR
        break;
      // Default values for other animals (can be expanded)
      default:
        shelterPerAnimal = 5;
        waterPerAnimal = 30;
        costPerAnimal = 800;
        break;
    }

    setState(() {
      _shelterArea = numAnimals * shelterPerAnimal;
      _waterPerDay = numAnimals * waterPerAnimal;
      _monthlyCost = numAnimals * costPerAnimal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2F2F2F)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Farm group',
          style: TextStyle(color: Color(0xFF2F2F2F), fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Text('3 of 4', style: TextStyle(color: Color(0xFF2F2F2F), fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStepIndicator(),
              const SizedBox(height: 24),
              _buildGroupDetailsCard(),
              const SizedBox(height: 24),
              _buildSmartRecommendationsCard(),
              const SizedBox(height: 32),
              _buildContinueButton(),
              const SizedBox(height: 12),
              _buildSkipButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Step 3 - Farm setup', style: TextStyle(fontSize: 18, color: Color(0xFF2F2F2F), fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(height: 6, width: 20, decoration: BoxDecoration(color: const Color(0xFF2F7D32).withOpacity(0.5), borderRadius: BorderRadius.circular(3))),
            const SizedBox(width: 4),
            Container(height: 6, width: 20, decoration: BoxDecoration(color: const Color(0xFF2F7D32).withOpacity(0.5), borderRadius: BorderRadius.circular(3))),
            const SizedBox(width: 4),
            Container(height: 6, width: 40, decoration: BoxDecoration(color: const Color(0xFF2F7D32), borderRadius: BorderRadius.circular(3))),
            const SizedBox(width: 12),
            const Text('Plan land, shelter & feeding', style: TextStyle(color: Color(0xFF6A6F5B))),
          ],
        )
      ],
    );
  }

  Widget _buildGroupDetailsCard() {
    List<String> purposes = _purposeOptions[widget.animalType] ?? ['Mixed'];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Group details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF2F2F2F))),
          const SizedBox(height: 16),
          _buildTextField(label: 'Number of animals', hint: 'e.g. 12', controller: _numberController, keyboardType: TextInputType.number),
          const SizedBox(height: 16),
          _buildTextField(label: 'Land available', hint: 'e.g. 1.5 acres', optional: true, icon: Icons.straighten),
          const SizedBox(height: 16),
          const Text('Purpose', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2F2F2F), fontSize: 16)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: purposes.map((purpose) {
              return ChoiceChip(
                label: Text(purpose),
                selected: _selectedPurpose == purpose,
                onSelected: (selected) {
                  setState(() {
                    if (selected) _selectedPurpose = purpose;
                  });
                },
                selectedColor: const Color(0xFF2F7D32),
                labelStyle: TextStyle(color: _selectedPurpose == purpose ? Colors.white : const Color(0xFF2F2F2F), fontWeight: FontWeight.w600),
                backgroundColor: const Color(0xFFF8F7F4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24), side: BorderSide.none),
                showCheckmark: false,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSmartRecommendationsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFFF8F7F4), borderRadius: BorderRadius.circular(28)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Smart recommendations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF2F2F2F))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: const Color(0xFF2F7D32), borderRadius: BorderRadius.circular(16)),
                child: const Text('Auto-calculated', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _RecommendationTile(label: 'Shelter area', value: '~ ${_shelterArea.toStringAsFixed(0)} m²')),
              const SizedBox(width: 12),
              const Expanded(child: _RecommendationTile(label: 'Feeding system', value: 'Semi-intensive')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _RecommendationTile(label: 'Water per day', value: '~ ${_waterPerDay.toStringAsFixed(0)} L')),
              const SizedBox(width: 12),
              const Expanded(child: _RecommendationTile(label: 'Cleaning frequency', value: 'Daily')),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Adjust the numbers above and we will refine these recommendations.', style: TextStyle(color: Color(0xFF6A6F5B), height: 1.4)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(color: const Color(0xFFDCCAB5), borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Estimated monthly cost', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF433B30))),
                Text(' ₹ ${_monthlyCost.toString()}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF433B30))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required String label, required String hint, TextEditingController? controller, bool optional = false, IconData? icon, TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2F2F2F), fontSize: 16)),
            if (optional) const Text('   Optional', style: TextStyle(color: Color(0xFF6A6F5B))), 
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: keyboardType == TextInputType.number ? [FilteringTextInputFormatter.digitsOnly] : [],
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFB0B4A3)),
            filled: true,
            fillColor: const Color(0xFFF8F7F4),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            suffixIcon: icon != null ? Icon(icon, color: const Color(0xFF6A6F5B)) : null,
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2F7D32),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        ),
        onPressed: () {},
        child: const Text('Continue to summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
      ),
    );
  }

  Widget _buildSkipButton() {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: const Text('Skip recommendations', style: TextStyle(color: Color(0xFF6A6F5B), fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _RecommendationTile extends StatelessWidget {
  final String label;
  final String value;
  final bool isAction;

  const _RecommendationTile({required this.label, required this.value, this.isAction = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF6A6F5B), fontSize: 13)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isAction ? const Color(0xFF2F7D32) : const Color(0xFF2F2F2F))),
        ],
      ),
    );
  }
}
