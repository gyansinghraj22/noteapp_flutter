// import 'package:flutter/material.dart';
// import 'package:noteapp/constants/app_colors.dart';
// import 'package:noteapp/features/login/widgets/background_with_image_widget.dart';

// class CustomSilverAppBar extends StatefulWidget {
//   const CustomSilverAppBar({super.key});

//   @override
//   State<CustomSilverAppBar> createState() => _CustomSilverAppBarState();
// }

// class _CustomSilverAppBarState extends State<CustomSilverAppBar> {
//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//               slivers: <Widget>[
//                 const SliverAppBar(
//                   backgroundColor: AppColor.spalshScreenBGColor,
//                   automaticallyImplyLeading: false,
//                   pinned: true,
//                   snap: true,
//                   floating: true,
//                   expandedHeight: 280,
//                   flexibleSpace: FlexibleSpaceBar(
//                     background: Hero(
//                       tag: "toolbar",
//                       child: BackgroundWithImageWidget(),
//                     ),
//                   ),
//                 ),
//                 SliverList(
//                   delegate: SliverChildBuilderDelegate(
//                     childCount: 1,
//                     (BuildContext context, int index) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           buildLoginFormField(context, formData),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             );
         
         
//   }
// }