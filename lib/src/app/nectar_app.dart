import 'dart:ui';

import 'package:flutter/material.dart';
import '../infrastructure/infrastructure.dart';

import 'app_theme.dart';
import 'route_config.dart';

class NectarApp extends StatefulWidget {
  const NectarApp({super.key});

  @override
  State<NectarApp> createState() => _NectarAppState();
}

class _NectarAppState extends State<NectarApp> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme(textTheme),
      scrollBehavior: const ScrollBehavior().copyWith(
        dragDevices: PointerDeviceKind.values.toSet(),
      ),
      routerConfig: AppRoute.routerConfig(UserModel.ui),
    );
  }
}
