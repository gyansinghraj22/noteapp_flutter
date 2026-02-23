// import 'package:flutter/material.dart';

// class CustomSelectMessageListView extends StatefulWidget {
//   final String title;
//   final String message;
//   final List options;
//   final bool? showSearch;
//   final void Function(Map)? onSelect;
//   CustomSelectMessageListView(
//       {Key? key,
//       required this.options,
//       required this.title,
//       this.showSearch,
//       this.onSelect,
//       required this.message})
//       : super(key: key);

//   @override
//   State<CustomSelectMessageListView> createState() =>
//       _CustomSelectMessageListViewState();
// }

// class _CustomSelectMessageListViewState
//     extends State<CustomSelectMessageListView> {
//   TextEditingController searchController = TextEditingController();

//   List allOptions = [];
//   @override
//   void initState() {
//     allOptions = widget.options;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BasePage(
//       showBottomNav: false,
//       showBackButton: true,
//       title: Text(
//         getLocalizedString(
//               context: context,
//               resString: ResString.select,
//             ) +
//             " " +
//             widget.title,
//         style: AppTextStyle.title,
//       ),
//       trailing: [],
//       body: Column(
//         children: [
//           if (widget.showSearch == true)
//             CustomFormField(
//               isDynamicForm: false,
//               onChanged: (val) {
//                 applog(val.toString());
//                 filterSearchResults(val.toLowerCase());
//               },
//               label: KeyString.search,
//               hintText: getLocalizedString(
//                   context: context, resString: ResString.search),
//               fieldType: FieldType.text,
//               controller: searchController,
//               prefixIcon: AppIcons.search,
//             ),
//           Text(widget.message),
//           Expanded(
//               child: allOptions.length > 0
//                   ? ListView.builder(
//                       physics: BouncingScrollPhysics(),
//                       itemCount: allOptions.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.only(
//                               left: 10.0, right: 10.0, top: 5, bottom: 5),
//                           child: CustomListViewCard(
//                             child: CustomListTile(
//                               trailing: showCountryFlag(
//                                   countryCode: allOptions[index]['value']),
//                               onPress: () {
//                                 Navigator.pop(context, {
//                                   'label': allOptions[index]['label'],
//                                   'value': allOptions[index]['value']
//                                 });
//                                 applog(
//                                   allOptions[index]['label'],
//                                 );

//                                 if (widget.onSelect != null) {
//                                   widget.onSelect!({
//                                     'label': allOptions[index]['label'],
//                                     'value': allOptions[index]['value']
//                                   });
//                                 }
//                               },
//                               title: Text("${allOptions[index]['label']}"),
//                             ),
//                           ),
//                         );
//                       })
//                   : Center(
//                       child: Text(
//                         getLocalizedString(
//                             context: context, resString: ResString.noDataFound),
//                         style: AppTextStyle.heading,
//                       ),
//                     )),
//         ],
//       ),
//     );
//   }

//   void filterSearchResults(String query) {
//     setState(() {
//       allOptions = widget.options
//           .where((e) =>
//               e["label"].toLowerCase().replaceAll(' ', '').contains(query))
//           .toList();
//     });
//   }
// }
