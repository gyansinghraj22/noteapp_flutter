// import 'package:flutter/material.dart';

// class PaginatedListView extends StatefulWidget {
//   final List<ListData> data;
//   final String? onNavigate;
//   Function(dynamic)? onSearch;
//   Function(dynamic)? loadMore;

//   PaginatedListView(
//       {super.key,
//       required this.data,
//       this.onNavigate,
//       this.onSearch,
//       this.loadMore});

//   @override
//   State<PaginatedListView> createState() => _PaginatedListViewState();
// }

// class _PaginatedListViewState extends State<PaginatedListView> {
//   TextEditingController searchController = TextEditingController();
//   bool showLoader = false;

//   bool isloadMore = false;
//   @override
//   Widget build(BuildContext context) {
//     List<ListData> data = widget.data;
//     return Column(
//       children: [
//         CustomFormField(
//           isDynamicForm: false,
//           onChanged: (val) {
//             widget.onSearch!.call(val);
//           },
//           label: getLocalizedString(
//             context: context,
//             resString: ResString.search,
//           ),
//           hintText:
//               getLocalizedString(context: context, resString: ResString.search),
//           fieldType: FieldType.text,
//           controller: searchController,
//           prefixIcon: AppIcons.search,
//         ),
//         Expanded(
//           child: NotificationListener(
//             onNotification: ((notification) {
//               if (notification is ScrollEndNotification) {
//                 setState(() {
//                   showLoader = true;
//                   isloadMore = true;
//                 });
//                 widget.loadMore!.call(1);
//                 Future.delayed(Duration(seconds: 2)).then((value) => {
//                       setState(() {
//                         showLoader = false;
//                       })
//                     });
//               }
//               return true;
//             }),
//             child: Stack(
//               children: [
//                 ListView.builder(
//                     physics: data.isEmpty
//                         ? NeverScrollableScrollPhysics()
//                         : BouncingScrollPhysics(),
//                     itemCount: data.length,
//                     scrollDirection: Axis.vertical,
//                     itemBuilder: (BuildContext context, index) {
//                       return Card(
//                         elevation: 2,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: CustomListTile(
//                             onPress: widget.onNavigate == null
//                                 ? null
//                                 : () {
//                                     Navigator.pushNamed(
//                                         context, widget.onNavigate.toString(),
//                                         arguments: data[index]);
//                                   },
//                             leading: CircleAvatar(
//                               child: Text(data[index].title![0].toString()),
//                             ),
//                             title: buildListTileTitle(data[index].title ?? ""),
//                             subTitle: buildListTileSubTitle(
//                                 data[index].subtitle ?? ""),
//                             trailing: data[index].trailing,
//                           ),
//                         ),
//                       );
//                     }),
//                 if (showLoader)
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: CircularProgressIndicator(),
//                   )
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
