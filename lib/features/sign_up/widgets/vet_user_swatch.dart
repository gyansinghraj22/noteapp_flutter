import 'package:flutter/material.dart';

class VetUserSwitch extends StatefulWidget {
  final ValueChanged<bool>? onChanged;

  /// true = Vet, false = User
  final bool initialIsVet;

  const VetUserSwitch({super.key, this.onChanged, this.initialIsVet = true});

  @override
  State<VetUserSwitch> createState() => _VetUserSwitchState();
}

class _VetUserSwitchState extends State<VetUserSwitch> {
  late bool isVet;

  @override
  void initState() {
    super.initState();
    isVet = widget.initialIsVet;
  }

  void _toggle(bool value) {
    setState(() => isVet = value);
    widget.onChanged?.call(isVet);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFFE6E6E6),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          /// Animated Indicator
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: isVet ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: 95,
              height: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF2EC4A6),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          /// Buttons
          Row(
            children: [
              _SegmentButton(
                label: 'Vet',
                isActive: isVet,
                onTap: () => _toggle(true),
              ),
              _SegmentButton(
                label: 'User',
                isActive: !isVet,
                onTap: () => _toggle(false),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _SegmentButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
