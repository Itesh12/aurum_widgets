import 'package:flutter/material.dart';
import 'package:aurum_widgets/aurum_widgets.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Aurum Widgets Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A),
          primary: const Color(0xFF1E3A8A),
        ),
        useMaterial3: true,
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _dropdownController = TextEditingController();
  final RxString _selectedBranch = "Main Office".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aurum Widgets Showcase"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AurumText.f18w600("Text Fields"),
            16.h,
            AurumTextField(
              controller: _textController,
              labelText: "Standard Input",
              hintText: "Enter some text...",
              onTap: () {},
            ),
            16.h,
            AurumTextField(
              controller: _dropdownController,
              labelText: "Dropdown Mode",
              hintText: "Select an option",
              dropdownField: true,
              onTap: _showBranchPicker,
            ),
            32.h,
            AurumText.f18w600("Buttons"),
            16.h,
            AurumPushButton(
              text: "Push Button (Primary)",
              onPressed: () async {
                Get.snackbar("Success", "Primary action triggered");
              },
            ),
            16.h,
            AurumOutlinedButton(
              text: "Outlined Button",
              onPressed: () {
                Get.snackbar("Info", "Secondary action triggered");
              },
            ),
            32.h,
            AurumText.f18w600("Typography"),
            16.h,
            AurumText.f20w600("Headline 20w600"),
            AurumText.f16w500("Sub-headline 16w500"),
            AurumText.f14w400("Body text 14w400 - clean and consistent."),
            16.h,
            const AurumMaybeMarqueeText(
              text: "This is a very long text that will automatically start scrolling if it doesn't fit in the available width, which is perfect for headers or labels in tight spaces.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            32.h,
            AurumPushButton(
              text: "Show Selection Bottom Sheet",
              onPressed: () async {
                _showBranchPicker();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showBranchPicker() {
    final List<String> branches = [
      "Main Office",
      "New York Branch",
      "London Hub",
      "Tokyo Station",
      "Paris Studio"
    ];

    AurumBottomSheet().showRBBottomSheet<String>(
      context: context,
      title: "Select Branch",
      originalList: branches.obs,
      selectedItem: _selectedBranch,
      getText: (branch) => branch,
    ).then((value) {
      if (value != null) {
        _dropdownController.text = value;
      }
    });
  }
}
