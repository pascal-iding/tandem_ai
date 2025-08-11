import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScrollIndicator extends StatelessWidget {
  const ScrollIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: 38,
        height: 38,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(38),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: SvgPicture.asset(
          'assets/icons/chevrons-down.svg',
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
