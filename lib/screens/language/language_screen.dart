import 'package:alandalos/screens/componets/my_appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:alandalos/utils/shared_preferences.dart';
import 'package:lottie/lottie.dart';

import '../../../../../utils/res.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  bool isChecked = false;
  int selectedIndex = 0;
  List languages = [
    {
      'name': 'العربية',
      'image':
          'https://cdn.britannica.com/79/5779-004-DC479508/Flag-Saudi-Arabia.jpg',
    },
    {
      'name': 'English',
      'image':
          'https://t2.gstatic.com/licensed-image?q=tbn:ANd9GcQVhwOar0FyOb_mmItcTAQFv1O4k8S_ZUEAI45O7dYC2rXRUWD-nWJwOQWJS2va8krELcDtY0JEVdQabkDkEdo',
    }
  ];

  @override
  initState() {
    getSelectedLanguage();
    super.initState();
  }

  getSelectedLanguage() async {
    var selectedLanguage =
        await SPUtill.getSelectLanguage(SPUtill.keySelectLanguage);
    if (kDebugMode) {
      print("selectedLanguage Local: $selectedLanguage");
    }
    if (selectedLanguage != null) {
      setState(() {
        selectedIndex = selectedLanguage;
        if (kDebugMode) {
          print("selectedIndex sssss: $selectedLanguage");
        }
      });
    } else {
      setState(() {
        selectedIndex = 0;
        if (kDebugMode) {
          print("selectedIndex deflt: $selectedIndex");
        }
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MyAppBar(
        title: tr('language_change'),
        haveLeading: true,
        onLeadingTap: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Lottie.asset('assets/images/language_lottie.json',
                  height: 160, width: 160, repeat: false),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text('choose_your_preferred_language',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54))
                .tr(),
            const SizedBox(
              height: 4,
            ),
            const Text(
              "please_select_your_language",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ).tr(),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        SPUtill.setLanguageIntValue(
                            SPUtill.keySelectLanguage, selectedIndex);
                        if (kDebugMode) {
                          print(selectedIndex);
                        }
                        if (selectedIndex == 0) {
                          context.setLocale(const Locale('ar', 'AR'));
                        } else if (selectedIndex == 1) {
                          context.setLocale(const Locale('en', 'US'));
                        }
                        getSelectedLanguage();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Row(
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              height: 36,
                              width: 36,
                              fit: BoxFit.cover,
                              imageUrl: "${languages[index]['image']}",
                              placeholder: (context, url) => Center(
                                child: Image.asset(
                                    "assets/images/placeholder_image.png"),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            languages[index]['name'] ?? "",
                            style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          SizedBox(
                            height: selectedIndex == index ? 36 : 0,
                            width: selectedIndex == index ? 36 : 0,
                            child: Icon(
                              Icons.check_circle_rounded,
                              size: selectedIndex == index ? 24 : 0,
                              color: AppColors.colorPrimary.withOpacity(
                                  selectedIndex == index ? 0.85 : 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
