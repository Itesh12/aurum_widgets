import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../models/address_models.dart';
import 'aurum_bottom_sheet.dart';

/// Defines the interface for external address data fetching.
abstract class AurumAddressProvider {
  /// Fetches country, state, and city hierarchy.
  Future<List<AurumCountry>> fetchCountries();

  /// Fetches location details for a given 6-digit pincode.
  Future<AurumPinCodeData?> fetchLocationByPincode(String pincode);
}

/// Controller to manage address form logic, state, and API integration.
class AurumAddressController extends GetxController {
  AurumAddressController({this.provider});

  /// Optional provider to handle API calls.
  final AurumAddressProvider? provider;

  /// Controllers for input fields.
  final TextEditingController addressLine1Controller = TextEditingController();
  final TextEditingController addressLine2Controller = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  /// Focus nodes for navigation.
  final FocusNode addressLine1Node = FocusNode();
  final FocusNode addressLine2Node = FocusNode();
  final FocusNode areaNode = FocusNode();
  final FocusNode cityNode = FocusNode();
  final FocusNode districtNode = FocusNode();
  final FocusNode stateNode = FocusNode();
  final FocusNode countryNode = FocusNode();
  final FocusNode pincodeNode = FocusNode();

  /// Observables for state management.
  final RxList<AurumCountry> countriesList = <AurumCountry>[].obs;
  final RxList<AurumAreaData> areaList = <AurumAreaData>[].obs;
  
  final Rx<AurumCountry?> selectedCountry = (null as AurumCountry?).obs;
  final Rx<AurumState?> selectedState = (null as AurumState?).obs;
  final Rx<AurumCity?> selectedCity = (null as AurumCity?).obs;

  final RxBool isAreaReadOnly = false.obs;
  final RxBool isCityReadOnly = false.obs;
  final RxBool isDistrictReadOnly = false.obs;
  final RxBool isLoading = false.obs;

  final RxInt _previousPincodeLength = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pincodeController.addListener(_onPincodeChanged);
    initData();
  }

  @override
  void onClose() {
    pincodeController.removeListener(_onPincodeChanged);
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    areaController.dispose();
    cityController.dispose();
    districtController.dispose();
    stateController.dispose();
    countryController.dispose();
    pincodeController.dispose();
    super.onClose();
  }

  /// Initial data load (fetches countries if provider is available).
  Future<void> initData() async {
    if (provider != null) {
      try {
        final results = await provider!.fetchCountries();
        countriesList.assignAll(results);
      } catch (e) {
        debugPrint("AurumAddressController: Error fetching countries: $e");
      }
    }
  }

  void _onPincodeChanged() {
    final String pincode = pincodeController.text.trim();
    if (pincode.length == 6 && _previousPincodeLength.value != 6) {
      _fetchLocation(pincode);
    } else if (pincode.length < 6 && _previousPincodeLength.value == 6) {
      _resetDownstreamFields();
    }
    _previousPincodeLength.value = pincode.length;
  }

  Future<void> _fetchLocation(String pincode) async {
    if (provider == null) return;

    isLoading(true);
    try {
      final data = await provider!.fetchLocationByPincode(pincode);
      if (data != null) {
        _populateFromPincode(data);
      }
    } finally {
      isLoading(false);
    }
  }

  void _populateFromPincode(AurumPinCodeData data) {
    if (data.district != null) districtController.text = data.district!;
    if (data.taluka != null) cityController.text = data.taluka!;
    if (data.area != null) areaController.text = data.area!;
    if (data.stateName != null) stateController.text = data.stateName!;
    if (data.countryName != null) countryController.text = data.countryName!;

    if (data.areaList != null) {
      areaList.assignAll(data.areaList!);
    }

    // Set read-only states if data was successfully fetched
    isDistrictReadOnly(data.district != null);
    isCityReadOnly(data.taluka != null);
    isAreaReadOnly(data.areaList != null && data.areaList!.isNotEmpty);
  }

  void _resetDownstreamFields() {
    areaController.clear();
    cityController.clear();
    districtController.clear();
    stateController.clear();
    countryController.clear();
    areaList.clear();
    isAreaReadOnly(false);
    isCityReadOnly(false);
    isDistrictReadOnly(false);
  }

  /// ------------------------
  /// UI Event Handlers
  /// ------------------------

  Future<void> onCountryTap(BuildContext context) async {
    if (countriesList.isEmpty) await initData();
    if (!context.mounted) return;
    if (countriesList.isEmpty) return;

    final AurumCountry? selected = await AurumBottomSheet().showRBBottomSheet<AurumCountry>(
      context: context,
      title: "Select Country",
      originalList: countriesList,
      selectedItem: selectedCountry,
      getText: (e) => e.name ?? "",
    );

    if (!context.mounted) return;

    if (selected != null) {
      HapticFeedback.lightImpact();
      selectedCountry(selected);
      countryController.text = selected.name ?? "";
      // Reset state/city
      selectedState(null);
      stateController.clear();
      selectedCity(null);
      districtController.clear();
    }
  }

  Future<void> onStateTap(BuildContext context) async {
    if (selectedCountry.value == null) return;
    final states = selectedCountry.value!.states ?? [];
    if (states.isEmpty) return;

    final AurumState? selected = await AurumBottomSheet().showRBBottomSheet<AurumState>(
      context: context,
      title: "Select State",
      originalList: states.obs,
      selectedItem: selectedState,
      getText: (e) => e.name ?? "",
    );

    if (!context.mounted) return;

    if (selected != null) {
      HapticFeedback.lightImpact();
      selectedState(selected);
      stateController.text = selected.name ?? "";
      // Reset city
      selectedCity(null);
      districtController.clear();
    }
  }

  Future<void> onAreaTap(BuildContext context) async {
    if (areaList.isEmpty) return;

    final AurumAreaData? selected = await AurumBottomSheet().showRBBottomSheet<AurumAreaData>(
      context: context,
      title: "Select Area",
      originalList: areaList,
      selectedItem: (null as AurumAreaData?).obs, // Simple selection
      getText: (e) => e.name ?? "",
    );

    if (!context.mounted) return;

    if (selected != null) {
      HapticFeedback.lightImpact();
      areaController.text = selected.name ?? "";
      if (selected.block != null) cityController.text = selected.block!;
      if (selected.district != null) districtController.text = selected.district!;
    }
  }

  /// Collects all current form data into a Map.
  Map<String, dynamic> getFormData() {
    return {
      "addressLine1": addressLine1Controller.text.trim(),
      "addressLine2": addressLine2Controller.text.trim(),
      "area": areaController.text.trim(),
      "city": cityController.text.trim(),
      "district": districtController.text.trim(),
      "state": stateController.text.trim(),
      "country": countryController.text.trim(),
      "pincode": pincodeController.text.trim(),
    };
  }
}
