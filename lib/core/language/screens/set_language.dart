import 'package:flutter/material.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/constants/key_string.dart';
import 'package:noteapp/core/common/custom_listview/custom_list_tile.dart';
import 'package:noteapp/core/common/custom_listview/custom_list_view_builder.dart';
import 'package:noteapp/core/helpers/bottom_dialogs.dart';
import 'package:noteapp/core/utils/shared_pref.dart';

List languages = [
  {"label": "English", "value": "ENG"},
  {"label": "Japan", "value": "JPN"},
];

class SetLanguage extends StatefulWidget {
  const SetLanguage({super.key});

  @override
  State<SetLanguage> createState() => _SetLanguageState();
}

class _SetLanguageState extends State<SetLanguage> {
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          BottomDialog.showBottomDialog(
            title: "Select Language",
            context: context,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: showLanguageList(),
            ),
          ).then((val) {
            getSelectLanguage();
          });
        },
        child: Container(
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.appThemeColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 4.0,
              right: 4.0,
              bottom: 2,
              top: 2,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(selectedLanguage.substring(0, 3).toUpperCase()),
                const SizedBox(width: 5),
                const Icon(
                  Icons.language,
                  color: AppColor.appThemeColor,
                  size: 26,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getSelectLanguage() {
    String language = SharedPref.getStringValue(KeyString.languageKey.name);

    selectedLanguage = language.isEmpty ? "English" : language;
  }

  Padding showLanguageList() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: languages.length,
        itemBuilder:
            (context, ind) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedLanguage = languages[ind]["value"];
                });
                // BlocProvider.of<LanguageCubit>(context)
                //     .changeLanguage(languages[ind]["value"]);
                Navigator.pop(context, languages[ind]['label']);
              },
              child: CustomCard(
                cardColor:
                    selectedLanguage == languages[ind]["value"]
                        ? AppColor.appThemeColor
                        : Colors.black,
                child: CustomListTile(
                  title: Text(languages[ind]["label"] ?? ""),
                  trailing: Icon(
                    Icons.check_box,
                    color:
                        selectedLanguage == languages[ind]["value"]
                            ? AppColor.appThemeColor
                            : Colors.transparent,
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
