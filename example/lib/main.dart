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

class MockAddressProvider extends AurumAddressProvider {
  @override
  Future<List<AurumCountry>> fetchCountries() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      AurumCountry(id: 1, name: "India", states: [
        AurumState(id: 10, name: "Gujarat", cities: [
          AurumCity(id: 101, name: "Ahmedabad"),
          AurumCity(id: 102, name: "Surat"),
        ]),
      ]),
      AurumCountry(id: 2, name: "USA"),
    ];
  }

  @override
  Future<AurumPinCodeData?> fetchLocationByPincode(String pincode) async {
    await Future.delayed(const Duration(seconds: 1));
    if (pincode == "380001") {
      return AurumPinCodeData(
        pinCode: "380001",
        district: "Ahmedabad",
        taluka: "Ahmedabad City",
        stateName: "Gujarat",
        countryName: "India",
        areaList: [
          AurumAreaData(name: "Lal Darwaja", block: "Ahmedabad City", district: "Ahmedabad"),
          AurumAreaData(name: "Khadia", block: "Ahmedabad City", district: "Ahmedabad"),
        ],
      );
    }
    return null;
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

  late final AurumAddressController _addressController;

  @override
  void initState() {
    super.initState();
    _addressController = Get.put(AurumAddressController(provider: MockAddressProvider()));
  }

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
            AurumText.f18w600("Address Widget"),
            16.h,
            AurumAddressWidget(
              controller: _addressController,
              isPincodeRequired: true,
            ),
            Obx(() => _addressController.isLoading.value
                ? const LinearProgressIndicator()
                : const SizedBox.shrink()),
            32.h,
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
            const AurumElevatedButton(
              text: "Elevated Button (Active)",
              onPressed: null,
            ),
            16.h,
            AurumOutlinedButton(
              text: "Outlined Button",
              onPressed: () {
                Get.snackbar("Info", "Secondary action triggered");
              },
            ),
            32.h,
            AurumText.f18w600("Authentication Components"),
            16.h,
            Row(
              children: [
                AurumText.f16w500("Login Section"),
                8.w,
                AurumInformationButton(message: "Tooltip explaining login requirements"),
              ],
            ),
            8.h,
            AurumPasswordValidator(password: "Pass123!"),
            16.h,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AurumText.f14w400("Finished?"),
                 AurumTextButton(
                  text: "Resend Code",
                  onPressed: () {
                    Get.snackbar("Auth", "Resend triggered");
                  },
                ),
              ],
            ),
            16.h,
            AurumText.f16w500("OTP Verification"),
            8.h,
            Center(
              child: AurumPinInput(
                onCompleted: (pin) {
                  Get.snackbar("OTP", "Pin entered: $pin");
                },
              ),
            ),
            16.h,
            AurumTimerCountdown(
              endTime: DateTime.now().add(const Duration(minutes: 2)),
              onEnd: () {
                Get.snackbar("Timer", "Time up!");
              },
            ),
            32.h,
            AurumText.f18w600("Social Connect"),
            16.h,
            AurumSocialButton(
              type: AurumSocialType.google,
              onPressed: () => Get.snackbar("Social", "Google Login"),
            ),
            12.h,
            AurumSocialButton(
              type: AurumSocialType.apple,
              onPressed: () => Get.snackbar("Social", "Apple Login"),
            ),
            32.h,
            AurumPushButton(
              text: "Launch Onboarding Pager",
              onPressed: () => _showOnboarding(),
            ),
            32.h,
            AurumText.f18w600("Media & Animations"),
            16.h,
            const Row(
              children: [
                Expanded(
                  child: AurumCachedImage(
                    imageUrl: "https://picsum.photos/200/200",
                    fit: BoxFit.cover,
                    height: 150,
                    circleView: true,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Center(
                    child: Icon(Icons.animation, size: 50, color: Colors.blue),
                  ),
                ),
              ],
            ),
            32.h,
            AurumText.f18w600("Typography"),
            16.h,
            AurumText.f20w600("Headline 20w600"),
            AurumText.f16w500("Sub-headline 16w500"),
            AurumText.f14w400("Body text 14w400 - clean and consistent."),
            16.h,
            const AurumMaybeMarqueeText(
              text: "This is a very long text that will automatically start scrolling if it doesn't fit in the available width.",
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

  void _showOnboarding() {
    Get.to(() => Scaffold(
      appBar: AppBar(title: const Text("Onboarding Demo")),
      body: AurumOnboardingPager(
        contents: const [
          AurumOnboardingContent(
            title: "Welcome to Aurum",
            description: "Premium UI components for your next big project.",
            imagePath: "assets/images/placeholder_image.png",
          ),
          AurumOnboardingContent(
            title: "Fast & Modular",
            description: "Easily integrate authentication and data flows.",
            imagePath: "assets/images/placeholder_image.png",
          ),
          AurumOnboardingContent(
            title: "Ready to Start?",
            description: "Build something amazing with our widget suite.",
            imagePath: "assets/images/placeholder_image.png",
          ),
        ],
        onFinish: () => Get.back(),
      ),
    ));
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
