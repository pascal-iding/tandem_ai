
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Alignment textAlign;
  final String? iconRightPath;
  final String? iconLeftPath;
  final Color borderColor;
  final Color textColor;
  final double borderWidth;

  const DefaultOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.textAlign = Alignment.center,
    this.iconRightPath,
    this.iconLeftPath,
    this.textColor = Colors.black,
    this.borderColor = Colors.black,
    this.borderWidth = 2
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 53,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          side: BorderSide(color: borderColor, width: borderWidth),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: textAlign, // your custom alignment
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: textColor,
                ),
              ),
            ),
            if (iconRightPath != null)
              Positioned(
                right: 12,
                child: SvgPicture.asset(
                  iconRightPath!
                )
              ),
            if (iconLeftPath != null)
              Positioned(
                left: 12,
                child: SvgPicture.asset(
                  iconLeftPath!
                )
              ),
          ],
        ),
      ),
    );
  }
}
