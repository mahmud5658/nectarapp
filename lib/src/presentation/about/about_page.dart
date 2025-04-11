import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/route_config.dart';
import 'package:grocery_app/src/presentation/_common/widgets/label_view.dart';
import 'package:grocery_app/src/service/firebase_auth.dart';
import 'package:grocery_app/src/service/shared_pref.dart';
import '../../app/app_theme.dart';
import '../_common/widgets/background_view.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String name = "Unknown";
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
    return BackgroundView.two(
      child: Scaffold(
        appBar: AppBar(
          title: const LabelView(label: "About"),
          centerTitle: true,
          leading: IconButton(
            onPressed: context.pop,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppTheme.primary,
            ),
          ),
        ),
        body:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),
              const SizedBox(height: 8),
              _BuildPersonTile(
                name: name,
                avatarUrl:
                    "https://cdn3.iconfinder.com/data/icons/business-avatar-1/512/3_avatar-512.png",
                profileUrl:
                    '',
                email: "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildPersonTile extends StatelessWidget {
  const _BuildPersonTile({
    required this.name,
    required this.avatarUrl,
    required this.profileUrl,
    required this.email,
  });

  final String name;
  final String avatarUrl;
  final String profileUrl;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ClipOval(
          child: Image.network(
            avatarUrl,
            height: 64,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
          onPressed: () async {
            final _authService = FirebaseAuthService();
            try {
              _authService.signOut();
              await SharedPrefService.setLoginStatus(false);
              context.pushReplacement(AppRoute.signIn);
            } catch (e) {
              print(e.toString());
            }
          },
          iconSize: 32,
          icon: const Icon(
            Icons.forward,
            color: AppTheme.primary,
          ),
        )
      ],
    );
  }
}
