
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tandem_ai/shared/themes/default_theme.dart';


class ActiveChatEntry extends StatelessWidget {
  final String profilePicturePath;
  final String name;
  final bool isActive;

  const ActiveChatEntry({
    super.key, 
    required this.profilePicturePath, 
    required this.name, 
    this.isActive=false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: 69,
              height: 69,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(profilePicturePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: Container(
                width: 21,
                height: 21,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary
                ),
                child: SvgPicture.asset(
                  'assets/icons/x.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onPrimary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 69,
          child: Row(
            children: [
              if (isActive)
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.success
                  ),
                ),
              if (isActive) const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
