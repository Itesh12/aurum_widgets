import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/aurum_maybe_marquee.dart';
import '../utils/aurum_text.dart';
import '../utils/spacing_extension.dart';
import 'aurum_outlined_button.dart';
import 'aurum_push_button.dart';

/// A utility class to show various types of bottom sheets.
///
/// Supported types:
/// - Standard bottom sheet with children.
/// - Radio button selection list [showRBBottomSheet].
/// - Checkbox selection list [showCBBottomSheet].
/// - Single selection checkbox list [showSingleSelectBottomSheet].
class AurumBottomSheet {
  /// Shows a standard bottom sheet with a title, subTitle, and a list of children widgets.
  /// 
  /// Provides optional [confirm] and [decline] buttons.
  Future<void> showBottomSheet({
    required String title,
    required List<Widget> children,
    String? subTitle,
    bool isDismissible = true,
    bool isCenterTitle = true,
    bool needConfirmButton = true,
    bool needDeclineButton = true,
    String confirmButtonText = "OK",
    String declineButtonText = "Cancel",
    Function() onConfirm = _defaultFunction,
    Function() onDecline = _defaultFunction,
    bool shouldCloseBottomSheet = true,
    bool needButtonsWithoutShadow = false,
    bool needButtons = true,
    bool extraPadding = true,
  }) async {
    final BuildContext context = Get.context!;
    await showModalBottomSheet<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                height: 4,
                width: Get.width / 6,
              ).paddingSymmetric(vertical: 16),
              if (title.isNotEmpty)
                Container(
                  alignment: isCenterTitle ? Alignment.center : Alignment.centerLeft,
                  padding: isCenterTitle ? null : const EdgeInsets.only(left: 16),
                  child: AurumText.f18w600(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ).paddingOnly(bottom: 16),
                ),
              if (subTitle != null)
                Container(
                  alignment: isCenterTitle ? Alignment.center : Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AurumText.f16w500(
                    subTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: children,
                  ),
                ),
              ),
              16.h,
              if (needButtons)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    16.w,
                    if (needDeclineButton)
                      Expanded(
                        child: AurumOutlinedButton(
                          text: declineButtonText,
                          onPressed: () async {
                            if (shouldCloseBottomSheet) {
                              Navigator.of(context).pop();
                            }
                            onDecline();
                          },
                        ),
                      )
                    else
                      const SizedBox(),
                    if (needDeclineButton && needConfirmButton) 16.w else 0.w,
                    if (needConfirmButton)
                      Expanded(
                        child: AurumPushButton(
                          text: confirmButtonText,
                          onPressed: () async {
                            if (shouldCloseBottomSheet) {
                              Navigator.of(context).pop();
                            }
                            onConfirm();
                          },
                        ),
                      )
                    else
                      const SizedBox(),
                    16.w,
                  ],
                ).paddingOnly(bottom: 16),
              16.w,
              if (extraPadding)
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom / 2,
                ),
            ],
          ),
        );
      },
      elevation: 4,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        side: BorderSide(color: Theme.of(context).colorScheme.primary),
      ),
      isScrollControlled: true,
      isDismissible: isDismissible,
    );
  }

  /// Shows a Radio Button (RB) selection bottom sheet.
  /// 
  /// The user can select exactly one item from the [originalList].
  Future<T?> showRBBottomSheet<T>({
    required BuildContext context,
    required String title,
    required RxList<T> originalList,
    required Rx<T?> selectedItem,
    bool enabled = true,
    Widget customWidget = const SizedBox(),
    required String Function(T) getText,
  }) async {
    final T? persistent = selectedItem.value;
    final Rx<T?> temp = persistent.obs;

    await showBottomSheet(
      title: title,
      children: <Widget>[
        customWidget,
        SingleChildScrollView(
          child: Column(
            children: List<Widget>.generate(
              originalList.length,
              (int index) {
                final T item = originalList[index];
                final bool isLast = (originalList.length - 1) == index;
                return Obx(
                  () {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          leading: Radio<T>(
                            value: item,
                            // ignore: deprecated_member_use
                            groupValue: temp.value,
                            activeColor: Theme.of(context).colorScheme.primary,
                            // ignore: deprecated_member_use
                            onChanged: enabled
                                ? (T? value) {
                                    temp.value = value;
                                  }
                                : null,
                            toggleable: true,
                          ),
                          title: AurumMaybeMarqueeText(
                            text: getText(item),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          onTap: enabled
                              ? () {
                                  temp.value = item;
                                }
                              : null,
                        ),
                        if (!isLast)
                          const Divider(
                            indent: 16,
                            endIndent: 16,
                          ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
      shouldCloseBottomSheet: false,
      needDeclineButton: true,
      needConfirmButton: true,
      onDecline: () {
        Navigator.of(context).pop();
      },
      onConfirm: () {
        selectedItem.value = temp.value;
        Navigator.of(context).pop();
      },
    );

    return selectedItem.value;
  }

  /// Shows a Checkbox (CB) selection bottom sheet.
  /// 
  /// The user can select multiple items from the [originalList].
  Future<List<T>> showCBBottomSheet<T>({
    required BuildContext context,
    required String title,
    required List<T> originalList,
    required List<T> selectedList,
    bool enabled = true,
    Widget customWidget = const SizedBox(),
    bool enableSelectAll = true,
    String? selectAllLabel,
    required String Function(T) getText,
  }) async {
    final RxList<T> temp = List<T>.from(selectedList).obs;
    final RxBool rxSelectAll = false.obs;

    void recomputeSelectAll() {
      rxSelectAll.value = originalList.isNotEmpty &&
          temp.length == originalList.length &&
          originalList.every(temp.contains);
    }

    recomputeSelectAll();

    await showBottomSheet(
      title: title,
      children: <Widget>[
        customWidget,
        if (enableSelectAll)
          Obx(() {
            return CheckboxListTile(
              enabled: enabled,
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              activeColor: Theme.of(context).colorScheme.primary,
              value: rxSelectAll.value,
              title: AurumMaybeMarqueeText(
                text: selectAllLabel ?? "Select All",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,
              ),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: enabled
                  ? (bool? value) {
                      if (value ?? false) {
                        temp.clear();
                        temp.addAll(originalList);
                      } else {
                        temp.clear();
                      }
                      recomputeSelectAll();
                    }
                  : null,
            );
          }),
        SingleChildScrollView(
          child: Column(
            children: List<Widget>.generate(
              originalList.length,
              (int index) {
                final T item = originalList[index];
                final bool isLast = (originalList.length - 1) == index;
                return Obx(() {
                  final bool isSelected = temp.contains(item);
                  return Column(
                    children: <Widget>[
                      CheckboxListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        value: isSelected,
                        title: AurumMaybeMarqueeText(
                          text: getText(item),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: enabled
                            ? (bool? value) {
                                if (value ?? false) {
                                  temp.add(item);
                                } else {
                                  temp.remove(item);
                                }
                                recomputeSelectAll();
                              }
                            : null,
                      ),
                      if (!isLast)
                        const Divider(
                          indent: 16,
                          endIndent: 16,
                        ),
                    ],
                  );
                });
              },
            ),
          ),
        ),
      ],
      shouldCloseBottomSheet: false,
      needDeclineButton: true,
      needConfirmButton: true,
      onDecline: () {
        Navigator.of(context).pop();
      },
      onConfirm: () {
        Navigator.of(context).pop();
      },
    );

    return temp.toList();
  }

  /// Shows a single selection checkbox list bottom sheet.
  /// 
  /// Unlike [showRBBottomSheet], this uses checkboxes which appear as single-select radios.
  Future<T?> showSingleSelectBottomSheet<T>({
    required BuildContext context,
    required String title,
    required List<T> originalList,
    T? selectedItem,
    bool enabled = true,
    Widget customWidget = const SizedBox(),
    required String Function(T) getText,
  }) async {
    final Rx<T?> tempSelected = Rx<T?>(selectedItem);

    await showBottomSheet(
      title: title,
      children: <Widget>[
        customWidget,
        SingleChildScrollView(
          child: Column(
            children: List<Widget>.generate(
              originalList.length,
              (int index) {
                final T item = originalList[index];
                final bool isLast = (originalList.length - 1) == index;

                return Obx(() {
                  final bool isSelected = tempSelected.value == item;
                  return Column(
                    children: <Widget>[
                      InkWell(
                        onTap: enabled
                            ? () {
                                if (isSelected) {
                                  tempSelected.value = null; // Deselect
                                } else {
                                  tempSelected.value = item; // Select
                                }
                              }
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: isSelected,
                                shape: const CircleBorder(),
                                onChanged: enabled
                                    ? (bool? newValue) {
                                        if (isSelected) {
                                          tempSelected.value = null;
                                        } else {
                                          tempSelected.value = item;
                                        }
                                      }
                                    : null,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: AurumMaybeMarqueeText(
                                  text: getText(item),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (!isLast)
                        const Divider(
                          indent: 16,
                          endIndent: 16,
                        ),
                    ],
                  );
                });
              },
            ),
          ),
        ),
      ],
      shouldCloseBottomSheet: false,
      needDeclineButton: true,
      needConfirmButton: true,
      onDecline: () {
        Navigator.of(context).pop();
      },
      onConfirm: () {
        Navigator.of(context).pop();
      },
    );

    return tempSelected.value;
  }

  static void _defaultFunction() {}
}
