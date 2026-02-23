import 'package:flutter/material.dart';

void showCustomBottomSheet({
  required BuildContext context,
  required Widget child,
  double height = 500,
  Color backgroundColor = const Color(0xFFF9F5FF),
  BorderRadius? borderRadius,
  Function? onClose,
}) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    builder: (context) => CustomBottomSheet(
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      onClose: onClose,
      child: child,
    ),
  );
}

class CustomBottomSheet extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;
  final BorderRadius? borderRadius;
  final Function? onClose;
  final double height;

  const CustomBottomSheet(
      {super.key,
      required this.child,
      this.backgroundColor = Colors.white,
      this.borderRadius,
      this.onClose,
      this.height = 550});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: widget.height,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius ??
            const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: widget.child,
    );
  }
}
