import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/route_config.dart';
import 'package:grocery_app/src/service/shared_pref.dart';
import '../../../app/app_theme.dart';
import '../../../infrastructure/infrastructure.dart';

class UserProfileHeaderView extends StatefulWidget {
  const UserProfileHeaderView({
    super.key,
    required this.model,
  });

  final UserModel model;

  @override
  State<UserProfileHeaderView> createState() => _UserProfileHeaderViewState();
}

class _UserProfileHeaderViewState extends State<UserProfileHeaderView> {
  String name = "unknown";
  @override
  void initState() {
    _loadUserName();
    super.initState();
  }

  Future<void> _loadUserName() async {
    final savedName =
        await SharedPrefService.getUserName(); // Make sure this method exists
    setState(() {
      name = savedName ?? "Unknown User";
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              "Hey ${name.split(' ')[0]}!",
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notification_important_rounded),
              color: AppTheme.primary,
            ),
            InkWell(
              onTap: () {
                context.push(AppRoute.author);
              },
              child: Material(
                shape: const CircleBorder(
                  side: BorderSide(color: AppTheme.primary),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  widget.model.avatar,
                  height: 48,
                  width: 48,
                ),
              ),
            )
          ],
        ),
        const Text("What do you like to find?")
      ],
    );
  }
}
