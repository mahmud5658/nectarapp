import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'src/app/grocery_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://iqmqyewpkwmiqxdxjbbe.supabase.co',
    anonKey:'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlxbXF5ZXdwa3dtaXF4ZHhqYmJlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM4NDE1NDYsImV4cCI6MjA1OTQxNzU0Nn0.92KH_vTAQSfaMWecwACSQ5Nnsnb9hpz7QwfDx0g4sws'
    );
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const GroceryApp(),
    ),
  );
}
