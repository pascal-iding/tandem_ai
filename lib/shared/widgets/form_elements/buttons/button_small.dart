
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ButtonSmall extends StatefulWidget {
  final String iconPath;
  final VoidCallback onPressed;
  const ButtonSmall({super.key, required this.iconPath, required this.onPressed});

  @override
  State<ButtonSmall> createState() => _ButtonSmallState();
}

class _ButtonSmallState extends State<ButtonSmall> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 51,
      height: 51,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: SvgPicture.asset(
          widget.iconPath,
          width: 24,
          height: 24,
          // colorFilter: ColorFilter.mode(
          //   Theme.of(context).colorScheme.onSurface,
          //   BlendMode.srcIn,
          // ),
        ),
        onPressed: widget.onPressed
      )
    );
  }
}
