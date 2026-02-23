import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/constants/app_images.dart';
import 'package:noteapp/constants/app_padding.dart';
import 'package:noteapp/core/common/custom_listview/custom_list_tile.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';

class ListData {
  int? id;
  String? title;
  String? subtitle;
  Widget? leading;
  Widget? trailing;
  ListData({this.title, this.subtitle, this.leading, this.trailing, this.id});
}

class CustomListViewBuilder extends StatefulWidget {
  final List<ListData> data;
  final Axis? scrollDirection;
  final String? onNavigate;
  final EdgeInsetsGeometry? listViewBodyPadding;
  final Function()? onTap;
  final double? borderRadius;
  final double? cardHeight;
  final Color? cardColor;
  final Color? cardBoarderColor;

  const CustomListViewBuilder({
    super.key,
    this.scrollDirection,
    this.onNavigate,
    this.listViewBodyPadding,
    this.onTap,
    this.borderRadius,
    this.cardHeight,
    this.cardColor,
    this.cardBoarderColor,
    required this.data,
  });

  @override
  State<CustomListViewBuilder> createState() => _CustomListViewBuilderState();
}

class _CustomListViewBuilderState extends State<CustomListViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.data.isNotEmpty
        ? ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: widget.data.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, index) {
            var data = widget.data[index];
            return CustomCard(
              cardBoarderColor: widget.cardBoarderColor,
              cardColor: widget.cardColor,
              cardHeight: widget.cardHeight,
              borderRadius: widget.borderRadius,
              padding: widget.listViewBodyPadding,
              onTap: widget.onTap,
              child: Padding(
                padding:
                    widget.listViewBodyPadding ??
                    EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      top: 12.h,
                      bottom: 6.h,
                    ),
                child: CustomListTile(
                  onPress:
                      widget.onNavigate == null
                          ? null
                          : () {
                            Navigator.pushNamed(
                              context,
                              widget.onNavigate.toString(),
                              arguments: data,
                            );
                          },
                  leading: Image.asset(
                    AppImages.avatarImage,
                    width: 80,
                    height: 80,
                  ),
                  title: Text(
                    data.title ?? "",
                    style:
                        context
                            .textStyle(palette: ColorPalete.slate, swatch: 700)
                            .large
                            .semiBold,
                  ),
                  subTitle: Text(
                    data.subtitle ?? "",
                    style:
                        context
                            .textStyle(palette: ColorPalete.slate)
                            .small
                            .regular,
                  ),
                  trailing: data.trailing,
                ),
              ),
            );
          },
        )
        : const Center(child: Text("No Statements Found"));
  }
}

class CustomCard extends StatelessWidget {
  final Color? cardColor;
  final Color? cardBoarderColor;
  final Widget child;
  final double? borderRadius;
  final double? cardHeight;
  final EdgeInsetsGeometry? padding;
  final Function()? onTap;
  const CustomCard({
    super.key,
    required this.child,
    this.cardColor,
    this.borderRadius,
    this.padding,
    this.onTap,
    this.cardHeight,
    this.cardBoarderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? AppPadding.onlyBottomPading,
      child: InkWell(
        onTap: onTap ?? () {},
        child: Container(
          height: cardHeight ?? 80.h,
          decoration: BoxDecoration(
            color:
                cardColor ??
                context.applyAppColor(palette: ColorPalete.white, swatch: 500),
            border: Border.all(
              color:
                  cardBoarderColor ??
                  context.applyAppColor(
                    palette: ColorPalete.slate,
                    swatch: 200,
                  ),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 4.r),
          ),
          child: child,
        ),
      ),
    );
  }
}

class CustomListViewCardSizedDefined extends StatelessWidget {
  final Color? cardColor;
  final Widget child;
  final double height;
  final double width;
  const CustomListViewCardSizedDefined({
    super.key,
    required this.child,
    this.cardColor,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: cardColor ?? AppColor.whiteColor,
      ),
      child: child,
    );
  }
}
