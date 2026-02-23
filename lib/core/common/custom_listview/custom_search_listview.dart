import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/constants/app_icons.dart';
import 'package:noteapp/core/common/base_page/base_page.dart';
import 'package:noteapp/core/common/custom_form_field/cuatom_form_field.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:noteapp/core/common/custom_listview/custom_list_tile.dart';
import 'package:noteapp/core/common/custom_listview/custom_list_view_builder.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';

class CustomSearchListView extends StatefulWidget {
  final String title;
  final List options;
  final bool? showSearch;
  final void Function(Map)? onSelect;
  const CustomSearchListView({
    super.key,
    required this.options,
    required this.title,
    this.showSearch,
    this.onSelect,
  });

  @override
  State<CustomSearchListView> createState() => _CustomSearchListViewState();
}

class _CustomSearchListViewState extends State<CustomSearchListView> {
  TextEditingController searchController = TextEditingController();

  List allOptions = [];
  @override
  void initState() {
    allOptions = widget.options;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CustomFormFieldConfig config = CustomFormFieldConfig(
      id: "search",
      onChanged: (val) {
        log(val.toString());
        filterSearchResults(val.toLowerCase());
      },
      label: "Search",
      hintText: "Search",
      fieldType: FieldType.text,
      controller: searchController,
      prefixIcon: AppIcons.search,
    );
    return BasePage(
      showBottomNav: false,
      showBackButton: true,
      title: Text(
        "Select ${widget.title}",
        style:
            context
                .textStyle(palette: ColorPalete.slate, swatch: 700)
                .large
                .semiBold,
      ),
      trailing: const [],
      body: Column(
        children: [
          if (widget.showSearch == true) CustomFormField(config: config),
          const SizedBox(height: 8),
          Expanded(
            child:
                allOptions.isNotEmpty
                    ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: allOptions.length,
                      itemBuilder: (context, index) {
                        return CustomCard(
                          child: CustomListTile(
                            onPress: () {
                              Navigator.pop(context, {
                                'label': allOptions[index]['label'],
                                'value': allOptions[index]['value'],
                              });
                              log(allOptions[index]['label']);

                              if (widget.onSelect != null) {
                                widget.onSelect!({
                                  'label': allOptions[index]['label'],
                                  'value': allOptions[index]['value'],
                                });
                              }
                            },
                            title: Text("${allOptions[index]['label']}"),
                          ),
                        );
                      },
                    )
                    : Center(
                      child: Text(
                        "No Data Found",
                        style:
                            context
                                .textStyle(
                                  palette: ColorPalete.slate,
                                  swatch: 700,
                                )
                                .large
                                .semiBold,
                      ),
                    ),
          ),
        ],
      ),
    );
  }

  void filterSearchResults(String query) {
    setState(() {
      allOptions =
          widget.options
              .where(
                (e) => e["label"]
                    .toLowerCase()
                    .replaceAll(' ', '')
                    .contains(query),
              )
              .toList();
    });
  }
}
