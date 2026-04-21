import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'aurum_address_controller.dart';
import 'aurum_text_field.dart';
import '../utils/spacing_extension.dart';

/// Configuration for labels and hints in the Address Widget.
class AurumAddressLabels {
  const AurumAddressLabels({
    this.addressLine1 = "Address Line 1",
    this.addressLine2 = "Address Line 2",
    this.area = "Area / Village",
    this.city = "City / Taluka",
    this.district = "District",
    this.state = "State",
    this.country = "Country",
    this.pincode = "Pincode",
    this.requiredSuffix = " *",
  });

  final String addressLine1;
  final String addressLine2;
  final String area;
  final String city;
  final String district;
  final String state;
  final String country;
  final String pincode;
  final String requiredSuffix;
}

/// A comprehensive address form widget that integrates with [AurumAddressController].
class AurumAddressWidget extends StatelessWidget {
  const AurumAddressWidget({
    required this.controller,
    this.labels = const AurumAddressLabels(),
    this.showAddressLine1 = true,
    this.showAddressLine2 = true,
    this.showArea = true,
    this.showCity = true,
    this.showDistrict = true,
    this.showState = true,
    this.showCountry = true,
    this.showPincode = true,
    this.isAddressLine1Required = false,
    this.isAddressLine2Required = false,
    this.isAreaRequired = false,
    this.isCityRequired = false,
    this.isDistrictRequired = false,
    this.isStateRequired = false,
    this.isCountryRequired = false,
    this.isPincodeRequired = false,
    this.isReadOnly = false,
    super.key,
  });

  final AurumAddressController controller;
  final AurumAddressLabels labels;

  final bool showAddressLine1;
  final bool showAddressLine2;
  final bool showArea;
  final bool showCity;
  final bool showDistrict;
  final bool showState;
  final bool showCountry;
  final bool showPincode;

  final bool isAddressLine1Required;
  final bool isAddressLine2Required;
  final bool isAreaRequired;
  final bool isCityRequired;
  final bool isDistrictRequired;
  final bool isStateRequired;
  final bool isCountryRequired;
  final bool isPincodeRequired;

  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showAddressLine1)
          _buildField(
            context,
            fieldController: controller.addressLine1Controller,
            label: labels.addressLine1,
            isRequired: isAddressLine1Required,
            focusNode: controller.addressLine1Node,
            maxLines: 2,
            keyboardType: TextInputType.streetAddress,
          ),
        if (showAddressLine2) ...[
          12.h,
          _buildField(
            context,
            fieldController: controller.addressLine2Controller,
            label: labels.addressLine2,
            isRequired: isAddressLine2Required,
            focusNode: controller.addressLine2Node,
            maxLines: 2,
            keyboardType: TextInputType.streetAddress,
          ),
        ],
        if (showPincode) ...[
          12.h,
          _buildField(
            context,
            fieldController: controller.pincodeController,
            label: labels.pincode,
            isRequired: isPincodeRequired,
            focusNode: controller.pincodeNode,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
            ],
          ),
        ],
        if (showArea) ...[
          12.h,
          Obx(() => _buildField(
                context,
                fieldController: controller.areaController,
                label: labels.area,
                isRequired: isAreaRequired,
                readOnly: controller.isAreaReadOnly.value,
                dropdownField: controller.areaList.isNotEmpty,
                onTap: () => controller.onAreaTap(context),
                focusNode: controller.areaNode,
              )),
        ],
        if (showCity) ...[
          12.h,
          Obx(() => _buildField(
                context,
                fieldController: controller.cityController,
                label: labels.city,
                isRequired: isCityRequired,
                readOnly: controller.isCityReadOnly.value,
                focusNode: controller.cityNode,
              )),
        ],
        if (showDistrict) ...[
          12.h,
          Obx(() => _buildField(
                context,
                fieldController: controller.districtController,
                label: labels.district,
                isRequired: isDistrictRequired,
                readOnly: controller.isDistrictReadOnly.value,
                focusNode: controller.districtNode,
              )),
        ],
        if (showState) ...[
          12.h,
          _buildField(
            context,
            fieldController: controller.stateController,
            label: labels.state,
            isRequired: isStateRequired,
            dropdownField: true,
            onTap: () => controller.onStateTap(context),
            focusNode: controller.stateNode,
          ),
        ],
        if (showCountry) ...[
          12.h,
          _buildField(
            context,
            fieldController: controller.countryController,
            label: labels.country,
            isRequired: isCountryRequired,
            dropdownField: true,
            onTap: () => controller.onCountryTap(context),
            focusNode: controller.countryNode,
          ),
        ],
      ],
    );
  }

  Widget _buildField(
    BuildContext context, {
    required TextEditingController fieldController,
    required String label,
    required bool isRequired,
    FocusNode? focusNode,
    int maxLines = 1,
    bool readOnly = false,
    bool dropdownField = false,
    VoidCallback? onTap,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    final bool effectiveReadOnly = isReadOnly || readOnly || dropdownField;

    return AurumTextField(
      controller: fieldController,
      labelText: "$label${isRequired ? labels.requiredSuffix : ''}",
      hintText: label,
      maxLines: maxLines,
      readOnly: effectiveReadOnly,
      dropdownField: dropdownField,
      onTap: () {
        if (dropdownField) {
          HapticFeedback.lightImpact();
        }
        onTap?.call();
      },
      keyboardType: effectiveReadOnly ? TextInputType.none : keyboardType,
      showCursor: !effectiveReadOnly,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      validator: (v) {
        if (isRequired && (v == null || v.trim().isEmpty)) {
          return "Please enter $label";
        }
        return null;
      },
    );
  }
}
