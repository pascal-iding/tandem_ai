
import 'package:flutter/material.dart';

import './active_chat_entry.dart';


class ActiveChatList extends StatelessWidget {
  const ActiveChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 69 + 5 + 8 + 16,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: ActiveChatEntry(
                    profilePicturePath: 'assets/images/sara.jpg', 
                    name: 'Saraaaaaaaaaaaaaa',
                    isActive: index == 0,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
