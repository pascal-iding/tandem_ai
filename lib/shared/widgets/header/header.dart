
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:tandem_ai/shared/widgets/form_elements/buttons/button_small.dart';


class Header extends StatefulWidget {
  final bool showBackButton;

  const Header({super.key, this.showBackButton = false});

  @override
  State<Header> createState() => _HeaderState();
}


class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.showBackButton? MainAxisAlignment.start: MainAxisAlignment.end,
      children: [
        if (!widget.showBackButton)
          ButtonSmall(
            iconPath: 'assets/icons/user.svg',
            onPressed: () => context.push('/profile')
          ),
        if (!widget.showBackButton)
          const SizedBox(width: 11),
        if (!widget.showBackButton)
          ButtonSmall(
            iconPath: 'assets/icons/more-vertical.svg',
            onPressed:() => print('Pressed')
          ),
        if (widget.showBackButton)
          ButtonSmall(
            iconPath: 'assets/icons/arrow-left.svg',
            onPressed:() => context.pop()
          ),
      ],
    );
  }
}
