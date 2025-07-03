import 'package:flutter/material.dart';
import 'package:safar/constants/app_theme/text_theme/text_theme.dart';
import 'package:safar/constants/app_theme/colour_theme/colour_theme.dart';
import 'package:safar/constants/app_theme/textfield_theme/textfield_theme.dart';
import 'package:safar/constants/app_theme/button_theme/responsive_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String kLastPickupKey = 'last_pickup_location';
const String kLastDropKey = 'last_drop_location';
const String kRecentLocationsKey = 'recent_locations';

class ChangeStopPage extends StatefulWidget {
  final String currentPickup;
  final String currentDrop;
  final List<String> recentLocations;

  const ChangeStopPage({
    super.key,
    required this.currentPickup,
    required this.currentDrop,
    this.recentLocations = const [],
  });

  @override
  State<ChangeStopPage> createState() => _ChangeStopPageState();
}

class _ChangeStopPageState extends State<ChangeStopPage> {
  String? selectedPickup;
  String? selectedDrop;
  List<String> recentLocations = [];
  late TextEditingController pickupController;
  late TextEditingController dropController;

  @override
  void initState() {
    super.initState();
    _loadSelections();
  }

  Future<void> _loadSelections() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedPickup = prefs.getString(kLastPickupKey) ?? widget.currentPickup;
      selectedDrop = prefs.getString(kLastDropKey) ?? widget.currentDrop;
      recentLocations = prefs.getStringList(kRecentLocationsKey) ?? [];
      pickupController = TextEditingController(text: selectedPickup);
      dropController = TextEditingController(text: selectedDrop);
    });
  }

  Future<void> _showAddressSearch(bool isPickup) async {
    // TODO: Replace with real Indian address search widget
    final result = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Search Address'),
        children: [
          SimpleDialogOption(
            onPressed: () =>
                Navigator.pop(context, 'Lokhandwala Complex Andheri'),
            child: const Text('Lokhandwala Complex Andheri'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(
              context,
              'C 509, Crystal Plaza, Andheri (w), Mumbai, Maharashtra - 400053.'
              '104/2, Vinayaka Nilaya, davanagere, karnataka',
            ),
            child: const Text(
              'C 509, Crystal Plaza, Andheri (w), Mumbai, Maharashtra - 400053.',
            ),
          ),
        ],
      ),
    );
    if (result != null) {
      setState(() {
        if (isPickup) {
          selectedPickup = result;
          pickupController.text = result;
        } else {
          selectedDrop = result;
          dropController.text = result;
        }
        // Add to recent locations if not already present
        if (!recentLocations.contains(result)) {
          recentLocations.insert(0, result);
          if (recentLocations.length > 5)
            recentLocations = recentLocations.sublist(0, 5);
        }
      });
      _saveSelections();
    }
  }

  Future<void> _saveSelections() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kLastPickupKey, selectedPickup ?? '');
    await prefs.setString(kLastDropKey, selectedDrop ?? '');
    await prefs.setStringList(kRecentLocationsKey, recentLocations);
  }

  @override
  Widget build(BuildContext context) {
    final canChange =
        selectedPickup != null &&
        selectedDrop != null &&
        selectedPickup!.isNotEmpty &&
        selectedDrop!.isNotEmpty;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: kMainHeadlineColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Change Stop', style: AppTextStyles.mainHeadline),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
          children: [
            const SizedBox(height: 8),
            Text(
              'Change pickup and drop location work only for a particular ride.',
              style: AppTextStyles.instructionText.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 18),
            _locationLabel(
              'Current Pick up Location',
              selectedPickup ?? widget.currentPickup,
              color: Colors.orange,
            ),
            const SizedBox(height: 18),
            _locationLabel(
              'Current Drop off Location',
              selectedDrop ?? widget.currentDrop,
              color: Colors.orange,
            ),
            const SizedBox(height: 2),
            Text(
              selectedDrop ?? widget.currentDrop,
              style: AppTextStyles.instructionText.copyWith(
                color: Colors.orange,
                fontWeight: FontWeight.w400,
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 18),
            Divider(thickness: 1, color: Colors.grey, height: 1),
            const SizedBox(height: 18),
            _searchField(
              label: 'Change Pick up stop',
              controller: pickupController,
              hint: 'Search Pick up location',
              onTap: () => _showAddressSearch(true),
            ),
            const SizedBox(height: 12),
            _searchField(
              label: 'Change Drop off stop',
              controller: dropController,
              hint: 'Search Drop off Location',
              onTap: () => _showAddressSearch(false),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Recent locations',
                    style: AppTextStyles.instructionText.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(child: Divider(thickness: 1, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8),
            if (recentLocations.isEmpty)
              Text(
                'No recent location',
                style: AppTextStyles.instructionText.copyWith(
                  color: Colors.grey,
                ),
              ),
            ...recentLocations.map(
              (loc) => Row(
                children: [
                  Expanded(
                    child: ListTile(
                      leading: const Icon(
                        Icons.history,
                        size: 20,
                        color: kMainHeadlineColor,
                      ),
                      title: Text(
                        loc,
                        style: AppTextStyles.instructionText.copyWith(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_upward,
                      size: 18,
                      color: kMainHeadlineColor,
                    ),
                    tooltip: 'Set as Pick up',
                    onPressed: () {
                      setState(() {
                        selectedPickup = loc;
                        pickupController.text = loc;
                      });
                      _saveSelections();
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_downward,
                      size: 18,
                      color: kMainHeadlineColor,
                    ),
                    tooltip: 'Set as Drop off',
                    onPressed: () {
                      setState(() {
                        selectedDrop = loc;
                        dropController.text = loc;
                      });
                      _saveSelections();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
        child: ResponsiveButton(
          text: 'Change',
          onPressed: canChange
              ? () {
                  // TODO: Implement backend call to change stop
                  Navigator.of(
                    context,
                  ).pop({'pickup': selectedPickup, 'drop': selectedDrop});
                }
              : null,
          outlined: !canChange,
          height: 45,
        ),
      ),
    );
  }

  Widget _locationLabel(String label, String value, {Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.instructionText.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTextStyles.instructionText.copyWith(
            color: color ?? kInstructionTextColor,
            fontWeight: FontWeight.w400,
            fontSize: 13,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _searchField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.instructionText.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            child: TextFormField(
              readOnly: true,
              controller: controller,
              decoration: baseTextFieldDecoration(hintText: hint).copyWith(
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                  color: kInstructionTextColor,
                ),
              ),
              style: AppTextStyles.instructionText.copyWith(fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}
