import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/route_config.dart';
import 'package:grocery_app/src/presentation/_common/widgets/label_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/app_theme.dart';
import '../_common/widgets/background_view.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BackgroundView.two(
      child: Scaffold(
        appBar: AppBar(
          title: const LabelView(label: "Contribution"),
          centerTitle: true,
          leading: IconButton(
            onPressed: context.pop,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppTheme.primary,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),
              Text(
                "App Developer(Flutter)",
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              const _BuildPersonTile(
                name: "Abdullah Al Mahmud",
                avatarUrl:
                    "https://avatars.githubusercontent.com/u/104672914?s=96&v=4",
                profileUrl:
                    'https://www.linkedin.com/in/abdullah-al-mahmud-873181236/',
                email: "",
              ),
              const Divider(
                height: 40,
              ),
              const SizedBox(height: 15),
              const _BuildPersonTile(
                name: "Fahim Al-Amin Auntu",
                avatarUrl:
                    "https://avatars.githubusercontent.com/u/104672914?s=96&v=4",
                profileUrl:
                    'https://www.linkedin.com/in/abdullah-al-mahmud-873181236/',
                email: "",
              ),
              const Divider(
                height: 40,
              ),
              const SizedBox(height: 15),
              const _BuildPersonTile(
                name: "Tanhatul Tasnim",
                avatarUrl:
                    "https://avatars.githubusercontent.com/u/104672914?s=96&v=4",
                profileUrl:
                    'https://www.linkedin.com/in/abdullah-al-mahmud-873181236/',
                email: "",
              ),
              const Divider(
                height: 40,
              ),
              const SizedBox(height: 15),
              const _BuildPersonTile(
                name: "Mst. Kanij Fatema",
                avatarUrl:
                    "https://avatars.githubusercontent.com/u/104672914?s=96&v=4",
                profileUrl:
                    'https://www.linkedin.com/in/abdullah-al-mahmud-873181236/',
                email: "",
              ),
              const Divider(
                height: 40,
              ),
              const SizedBox(height: 15),
              const _BuildPersonTile(
                name: "KM Tanvir Imam",
                avatarUrl:
                    "https://avatars.githubusercontent.com/u/104672914?s=96&v=4",
                profileUrl:
                    'https://www.linkedin.com/in/abdullah-al-mahmud-873181236/',
                email: "",
              )
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
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(profileUrl);

        try {
          launchUrl(
            uri,
            mode: LaunchMode.externalApplication,
          );
        } catch (_) {}
      },
      child: Row(
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
          const IconButton(
            onPressed: null,
            iconSize: 32,
            icon: Icon(
              Icons.forward,
              color: AppTheme.primary,
            ),
          )
        ],
      ),
    );
  }
}
