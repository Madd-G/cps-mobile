import 'package:cps_mobile/src/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  final UserEntity user;

  const UserList({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.name ?? 'No Name',
                  style: const TextStyle(color: Colors.black, fontSize: 18.0),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  user.name ?? 'No Name',
                  style: const TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
