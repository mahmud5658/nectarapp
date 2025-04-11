import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';

class AuthBackGroundWrapper extends StatelessWidget {
  const AuthBackGroundWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    const path = "assets/images/top_banner_fruits.png";

    const gap = SizedBox(height: 24);
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.white),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Image.asset(
            path,
            fit: BoxFit.fitWidth,
          ),
        ),
        Align(alignment: Alignment.topCenter, child: AppBar()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -4),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: AppTheme.background,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24)
                    .copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom),
                child: Column(
                  children: [
                    gap,
                    FractionallySizedBox(
                      widthFactor: .5,
                      child: Container(
                        height: 4,
                        decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    gap,
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



import 'package:flutter/material.dart';
import '../../app/route_config.dart';
import '../_common/widgets/background_view.dart';

import '../_common/widgets/app_button.dart';

class LoginOptionSelectionPage extends StatelessWidget {
  const LoginOptionSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BackgroundView.two(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        "Grocery shopping has never been this much fun ",
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppButton.large(
                            onTap: () {
                              context.push(AppRoute.signIn);
                            },
                            label: "Login",
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Don't Have an account",
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          AppButton.large(
                            onTap: () {
                              context.push(AppRoute.signUp);
                            },
                            label: "Sign Up",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  "assets/images/bottom_ve.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/src/app/route_config.dart';
import 'package:grocery_app/src/app/utils/input_validator.dart';
import 'package:grocery_app/src/presentation/auth/auth.dart';
import 'package:grocery_app/src/presentation/auth/widgets/already_account.dart';
import 'package:grocery_app/src/service/firebase_auth.dart';
import '../_common/widgets/app_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    return AuthBackGroundWrapper(
      title: "Create an account now",
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
                controller: _nameController,
                hint: "Name",
                icon: const Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name required";
                  } else if (!InputValidator.isValidName(value)) {
                    return "Enter your valid name";
                  }
                  return null;
                }),
            gap,
            AppTextField(
                controller: _emailController,
                hint: "Email",
                icon: const Icon(Icons.email_outlined),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email required";
                  } else if (!InputValidator.isValidEmail(value)) {
                    return "Enter your valid Email";
                  }
                  return null;
                }),
            gap,
            AppTextField(
                controller: _passwordController,
                hint: "Password",
                obscureText: true,
                icon: const Icon(Icons.lock),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password required";
                  } else if (!InputValidator.isValidPassword(value)) {
                    return "Enter your valid password";
                  }
                  return null;
                }),
            gap,
            AppTextField(
              controller: _cPasswordController,
              hint: "Confirm Password",
              obscureText: true,
              icon: const Icon(Icons.lock),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please confirm your password";
                }
                if (value != _passwordController.text) {
                  return "Passwords do not match";
                }
                return null;
              },
            ),
            gap,
            const SingInOptionView(),
            gap,
            gap,
            FractionallySizedBox(
              widthFactor: .75,
              child: SizedBox(
                height: 56,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.red,
                      ))
                    : ElevatedButton(
                        onPressed: _signUp,
                        child: const Text("Sign Up"),
                      ),
              ),
            ),
            gap,
            const AlreadyHaveAnAccountView(),
            gap,
          ],
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    final _authService = FirebaseAuthService();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      final error = await _authService.signUp(email, password);

      setState(() {
        _isLoading = false;
      });

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Sign up failed'),
          ),
        );
      } else {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'name': name,
            'email': email,
            'createdAt': Timestamp.now(),
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed up successfully!')),
        );
        context.push(AppRoute.signIn);
      }
    }
  }
}
import 'package:flutter/material.dart';
import '../../app/route_config.dart';

import '../_common/widgets/app_text_field.dart';
import 'auth.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    final textTheme = Theme.of(context).textTheme;
    return AuthBackGroundWrapper(
      title: "Verification",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Enter your email here ! we will send you verification code.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          const AppTextField(
            hint: "Email",
            icon: Icon(Icons.email),
          ),
          const SizedBox(height: 32),
          FractionallySizedBox(
            widthFactor: .75,
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  context.push(AppRoute.otp);
                },
                child: const Text("Send Code"),
              ),
            ),
          ),
          gap,
        ],
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/utils/input_validator.dart';
import 'package:grocery_app/src/presentation/auth/auth.dart';
import 'package:grocery_app/src/service/firebase_auth.dart';
import 'package:grocery_app/src/service/shared_pref.dart';
import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../_common/widgets/app_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);

    return AuthBackGroundWrapper(
      title: "Welcome back!",
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            gap,
            AppTextField(
              controller: _emailController,
              hint: "Email",
              icon: const Icon(Icons.email),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                } else if (!InputValidator.isValidEmail(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            gap,
            AppTextField(
              controller: _passwordController,
              hint: "Password",
              obscureText: true,
              icon: const Icon(Icons.lock),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                } else if (!InputValidator.isValidPassword(value)) {
                  return 'Enter a valid password';
                }
                return null;
              },
            ),
            gap,
            TextButton(
              onPressed: () {
                context.push(AppRoute.resetPassword);
              },
              child: const Text("Forgot password?"),
            ),
            gap,
            const SingInOptionView(),
            const SizedBox(height: 32),
            FractionallySizedBox(
              widthFactor: .75,
              child: SizedBox(
                height: 56,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text("Sign In"),
                      ),
              ),
            ),
            gap,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don’t have an account? "),
                InkWell(
                  onTap: () {
                    context.pushReplacement(AppRoute.signUp);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: AppTheme.primary),
                    ),
                  ),
                ),
              ],
            ),
            gap,
          ],
        ),
      ),
    );
  }

  void _login() async {
  final _authService = FirebaseAuthService();
  if (_formKey.currentState!.validate()) {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    final error = await _authService.signIn(email, password);

    setState(() {
      _isLoading = false;
    });

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Sign in failed'),
        ),
      );
    } else {
      final user = FirebaseAuth.instance.currentUser;
      
      if (user != null) {
        final userEmail = user.email;
        final userName = await _fetchUserNameFromFirestore(user.uid);
        if (userEmail != null) {
          await SharedPrefService.setUserEmail(userEmail);
        }
        if (userName != null) {
          await SharedPrefService.setUserName(userName);
        }
        await SharedPrefService.setLoginStatus(true);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed in successfully!')),
        );
        context.pushReplacement(AppRoute.home);
      }
    }
  }
}
Future<String?> _fetchUserNameFromFirestore(String uid) async {
  try {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userDoc.exists) {
      return userDoc.data()?['name'];
    }
  } catch (e) {
    print("Error fetching user name: $e");
  }
  return null;
}
  
}
import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';

class SingInOptionView extends StatelessWidget {
  const SingInOptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Or",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            Icons.facebook,
            Icons.g_mobiledata,
            Icons.inbox,
          ]
              .map(
                (e) => Card(
                  shape: const CircleBorder(),
                  elevation: 4,
                  child: IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF5C5C5C),
                      shadowColor: Colors.green,
                    ),
                    onPressed: () {},
                    icon: Icon(e),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAgcBrr3ZmsQ_MkCeJpuDudVm_U8f5diT4',
    appId: '1:665270910955:web:5e2b5df4f3d7070feb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    authDomain: 'nectar-5294a.firebaseapp.com',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    measurementId: 'G-HQK62DCV9D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXevK09S24HiAHuqsMz-x66Enlg_t31O4',
    appId: '1:665270910955:android:ba9a1df018aec47feb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAj24GfjsjWpT1GrcwyIN0MLYjOd9U-pcA',
    appId: '1:665270910955:ios:8bea429294a76a55eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    iosBundleId: 'com.example.groceryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAj24GfjsjWpT1GrcwyIN0MLYjOd9U-pcA',
    appId: '1:665270910955:ios:8bea429294a76a55eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    iosBundleId: 'com.example.groceryApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAgcBrr3ZmsQ_MkCeJpuDudVm_U8f5diT4',
    appId: '1:665270910955:web:5a63b11252913007eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    authDomain: 'nectar-5294a.firebaseapp.com',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    measurementId: 'G-1LNFZ1PJ2J',
  );
}
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'src/app/nectar_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const NectarApp(),
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/app_theme.dart';
import 'package:grocery_app/src/app/route_config.dart';

class AlreadyHaveAnAccountView extends StatelessWidget {
  const AlreadyHaveAnAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?"),
        InkWell(
          onTap: () {
            context.pushReplacement(AppRoute.signIn);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 4, right: 8, top: 8, bottom: 8),
            child: Text(
              "Login",
              style: TextStyle(color: AppTheme.primary),
            ),
          ),
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../_common/_common.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const gap = SizedBox(height: 32);

    return BackgroundView.single(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 64,
                right: 0,
                left: 0,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    "assets/images/landing_fruits.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Positioned(
                left: 24,
                right: 24,
                bottom: 64,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Buy ",
                        children: [
                          TextSpan(
                            text: "Grocery",
                            style: textTheme.headlineLarge?.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                          const TextSpan(text: " items easily with us")
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: textTheme.headlineLarge?.copyWith(),
                    ),
                    gap,
                    const Text(
                      "If you keep good food in your fridge, you will eat good food",
                      textAlign: TextAlign.center,
                    ),
                    gap,
                    AppButton.large(
                      onTap: () {
                        context.push(AppRoute.loginOption);
                      },
                      label: "Get Started",
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
lib/src/presentation/auth/widgets/background_auth_wrapper.dart
import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';

class AuthBackGroundWrapper extends StatelessWidget {
  const AuthBackGroundWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    const path = "assets/images/top_banner_fruits.png";

    const gap = SizedBox(height: 24);
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.white),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Image.asset(
            path,
            fit: BoxFit.fitWidth,
          ),
        ),
        Align(alignment: Alignment.topCenter, child: AppBar()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -4),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: AppTheme.background,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24)
                    .copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom),
                child: Column(
                  children: [
                    gap,
                    FractionallySizedBox(
                      widthFactor: .5,
                      child: Container(
                        height: 4,
                        decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    gap,
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
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
import 'package:flutter/material.dart';
import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../../infrastructure/infrastructure.dart';
import '../_common/_common.dart';
import 'widgets/product_description.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.model,
  });

  final ProductModel model;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int itemCount = 1;

  @override
  void initState() {
    super.initState();
    itemCount = widget.model.orderCounter;
  }

  String get totalPrice => (widget.model.price * itemCount).toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BackgroundView.triple(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: context.pop,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppTheme.borderColor,
            ),
          ),
          actions: [
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.shopping_cart_rounded,
                  color: AppTheme.primary,
                ),
              ),
              onTap: () {},
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total:$totalPrice Tk",
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppButton(
                label: "Add to cart",
                onTap: () {
                  ShopProvider.of(context).addToCart(p: widget.model, counter: itemCount);
                  context.pop();
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            clipBehavior: Clip.none,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList.list(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 12,
                      child: Image.network(
                        widget.model.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const ImageErrorView(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: ItemCounter(
                        initialValue: itemCount,
                        onChanged: (v) {
                          itemCount = v;
                          setState(() {});
                        },
                      ),
                    ),
                    ProductDescription(model: widget.model),
                    const SizedBox(height: 24),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';

class AuthBackGroundWrapper extends StatelessWidget {
  const AuthBackGroundWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    const path = "assets/images/top_banner_fruits.png";

    const gap = SizedBox(height: 24);
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.white),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Image.asset(
            path,
            fit: BoxFit.fitWidth,
          ),
        ),
        Align(alignment: Alignment.topCenter, child: AppBar()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -4),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: AppTheme.background,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24)
                    .copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom),
                child: Column(
                  children: [
                    gap,
                    FractionallySizedBox(
                      widthFactor: .5,
                      child: Container(
                        height: 4,
                        decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    gap,
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



import 'package:flutter/material.dart';
import '../../app/route_config.dart';
import '../_common/widgets/background_view.dart';

import '../_common/widgets/app_button.dart';

class LoginOptionSelectionPage extends StatelessWidget {
  const LoginOptionSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BackgroundView.two(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        "Grocery shopping has never been this much fun ",
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppButton.large(
                            onTap: () {
                              context.push(AppRoute.signIn);
                            },
                            label: "Login",
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Don't Have an account",
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          AppButton.large(
                            onTap: () {
                              context.push(AppRoute.signUp);
                            },
                            label: "Sign Up",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  "assets/images/bottom_ve.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/src/app/route_config.dart';
import 'package:grocery_app/src/app/utils/input_validator.dart';
import 'package:grocery_app/src/presentation/auth/auth.dart';
import 'package:grocery_app/src/presentation/auth/widgets/already_account.dart';
import 'package:grocery_app/src/service/firebase_auth.dart';
import '../_common/widgets/app_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    return AuthBackGroundWrapper(
      title: "Create an account now",
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
                controller: _nameController,
                hint: "Name",
                icon: const Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name required";
                  } else if (!InputValidator.isValidName(value)) {
                    return "Enter your valid name";
                  }
                  return null;
                }),
            gap,
            AppTextField(
                controller: _emailController,
                hint: "Email",
                icon: const Icon(Icons.email_outlined),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email required";
                  } else if (!InputValidator.isValidEmail(value)) {
                    return "Enter your valid Email";
                  }
                  return null;
                }),
            gap,
            AppTextField(
                controller: _passwordController,
                hint: "Password",
                obscureText: true,
                icon: const Icon(Icons.lock),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password required";
                  } else if (!InputValidator.isValidPassword(value)) {
                    return "Enter your valid password";
                  }
                  return null;
                }),
            gap,
            AppTextField(
              controller: _cPasswordController,
              hint: "Confirm Password",
              obscureText: true,
              icon: const Icon(Icons.lock),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please confirm your password";
                }
                if (value != _passwordController.text) {
                  return "Passwords do not match";
                }
                return null;
              },
            ),
            gap,
            const SingInOptionView(),
            gap,
            gap,
            FractionallySizedBox(
              widthFactor: .75,
              child: SizedBox(
                height: 56,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.red,
                      ))
                    : ElevatedButton(
                        onPressed: _signUp,
                        child: const Text("Sign Up"),
                      ),
              ),
            ),
            gap,
            const AlreadyHaveAnAccountView(),
            gap,
          ],
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    final _authService = FirebaseAuthService();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      final error = await _authService.signUp(email, password);

      setState(() {
        _isLoading = false;
      });

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Sign up failed'),
          ),
        );
      } else {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'name': name,
            'email': email,
            'createdAt': Timestamp.now(),
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed up successfully!')),
        );
        context.push(AppRoute.signIn);
      }
    }
  }
}
import 'package:flutter/material.dart';
import '../../app/route_config.dart';

import '../_common/widgets/app_text_field.dart';
import 'auth.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    final textTheme = Theme.of(context).textTheme;
    return AuthBackGroundWrapper(
      title: "Verification",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Enter your email here ! we will send you verification code.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          const AppTextField(
            hint: "Email",
            icon: Icon(Icons.email),
          ),
          const SizedBox(height: 32),
          FractionallySizedBox(
            widthFactor: .75,
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  context.push(AppRoute.otp);
                },
                child: const Text("Send Code"),
              ),
            ),
          ),
          gap,
        ],
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/utils/input_validator.dart';
import 'package:grocery_app/src/presentation/auth/auth.dart';
import 'package:grocery_app/src/service/firebase_auth.dart';
import 'package:grocery_app/src/service/shared_pref.dart';
import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../_common/widgets/app_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);

    return AuthBackGroundWrapper(
      title: "Welcome back!",
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            gap,
            AppTextField(
              controller: _emailController,
              hint: "Email",
              icon: const Icon(Icons.email),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                } else if (!InputValidator.isValidEmail(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            gap,
            AppTextField(
              controller: _passwordController,
              hint: "Password",
              obscureText: true,
              icon: const Icon(Icons.lock),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                } else if (!InputValidator.isValidPassword(value)) {
                  return 'Enter a valid password';
                }
                return null;
              },
            ),
            gap,
            TextButton(
              onPressed: () {
                context.push(AppRoute.resetPassword);
              },
              child: const Text("Forgot password?"),
            ),
            gap,
            const SingInOptionView(),
            const SizedBox(height: 32),
            FractionallySizedBox(
              widthFactor: .75,
              child: SizedBox(
                height: 56,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text("Sign In"),
                      ),
              ),
            ),
            gap,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don’t have an account? "),
                InkWell(
                  onTap: () {
                    context.pushReplacement(AppRoute.signUp);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: AppTheme.primary),
                    ),
                  ),
                ),
              ],
            ),
            gap,
          ],
        ),
      ),
    );
  }

  void _login() async {
  final _authService = FirebaseAuthService();
  if (_formKey.currentState!.validate()) {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    final error = await _authService.signIn(email, password);

    setState(() {
      _isLoading = false;
    });

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Sign in failed'),
        ),
      );
    } else {
      final user = FirebaseAuth.instance.currentUser;
      
      if (user != null) {
        final userEmail = user.email;
        final userName = await _fetchUserNameFromFirestore(user.uid);
        if (userEmail != null) {
          await SharedPrefService.setUserEmail(userEmail);
        }
        if (userName != null) {
          await SharedPrefService.setUserName(userName);
        }
        await SharedPrefService.setLoginStatus(true);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed in successfully!')),
        );
        context.pushReplacement(AppRoute.home);
      }
    }
  }
}
Future<String?> _fetchUserNameFromFirestore(String uid) async {
  try {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userDoc.exists) {
      return userDoc.data()?['name'];
    }
  } catch (e) {
    print("Error fetching user name: $e");
  }
  return null;
}
  
}
import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';

class SingInOptionView extends StatelessWidget {
  const SingInOptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Or",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            Icons.facebook,
            Icons.g_mobiledata,
            Icons.inbox,
          ]
              .map(
                (e) => Card(
                  shape: const CircleBorder(),
                  elevation: 4,
                  child: IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF5C5C5C),
                      shadowColor: Colors.green,
                    ),
                    onPressed: () {},
                    icon: Icon(e),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAgcBrr3ZmsQ_MkCeJpuDudVm_U8f5diT4',
    appId: '1:665270910955:web:5e2b5df4f3d7070feb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    authDomain: 'nectar-5294a.firebaseapp.com',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    measurementId: 'G-HQK62DCV9D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXevK09S24HiAHuqsMz-x66Enlg_t31O4',
    appId: '1:665270910955:android:ba9a1df018aec47feb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAj24GfjsjWpT1GrcwyIN0MLYjOd9U-pcA',
    appId: '1:665270910955:ios:8bea429294a76a55eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    iosBundleId: 'com.example.groceryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAj24GfjsjWpT1GrcwyIN0MLYjOd9U-pcA',
    appId: '1:665270910955:ios:8bea429294a76a55eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    iosBundleId: 'com.example.groceryApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAgcBrr3ZmsQ_MkCeJpuDudVm_U8f5diT4',
    appId: '1:665270910955:web:5a63b11252913007eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    authDomain: 'nectar-5294a.firebaseapp.com',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    measurementId: 'G-1LNFZ1PJ2J',
  );
}
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'src/app/nectar_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const NectarApp(),
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/app_theme.dart';
import 'package:grocery_app/src/app/route_config.dart';

class AlreadyHaveAnAccountView extends StatelessWidget {
  const AlreadyHaveAnAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?"),
        InkWell(
          onTap: () {
            context.pushReplacement(AppRoute.signIn);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 4, right: 8, top: 8, bottom: 8),
            child: Text(
              "Login",
              style: TextStyle(color: AppTheme.primary),
            ),
          ),
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../_common/_common.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const gap = SizedBox(height: 32);

    return BackgroundView.single(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 64,
                right: 0,
                left: 0,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    "assets/images/landing_fruits.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Positioned(
                left: 24,
                right: 24,
                bottom: 64,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Buy ",
                        children: [
                          TextSpan(
                            text: "Grocery",
                            style: textTheme.headlineLarge?.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                          const TextSpan(text: " items easily with us")
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: textTheme.headlineLarge?.copyWith(),
                    ),
                    gap,
                    const Text(
                      "If you keep good food in your fridge, you will eat good food",
                      textAlign: TextAlign.center,
                    ),
                    gap,
                    AppButton.large(
                      onTap: () {
                        context.push(AppRoute.loginOption);
                      },
                      label: "Get Started",
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
lib/src/presentation/auth/widgets/background_auth_wrapper.dart
import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';

class AuthBackGroundWrapper extends StatelessWidget {
  const AuthBackGroundWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    const path = "assets/images/top_banner_fruits.png";

    const gap = SizedBox(height: 24);
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.white),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Image.asset(
            path,
            fit: BoxFit.fitWidth,
          ),
        ),
        Align(alignment: Alignment.topCenter, child: AppBar()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -4),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: AppTheme.background,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24)
                    .copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom),
                child: Column(
                  children: [
                    gap,
                    FractionallySizedBox(
                      widthFactor: .5,
                      child: Container(
                        height: 4,
                        decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    gap,
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
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
import 'package:flutter/material.dart';
import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../../infrastructure/infrastructure.dart';
import '../_common/_common.dart';
import 'widgets/product_description.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.model,
  });

  final ProductModel model;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int itemCount = 1;

  @override
  void initState() {
    super.initState();
    itemCount = widget.model.orderCounter;
  }

  String get totalPrice => (widget.model.price * itemCount).toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BackgroundView.triple(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: context.pop,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppTheme.borderColor,
            ),
          ),
          actions: [
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.shopping_cart_rounded,
                  color: AppTheme.primary,
                ),
              ),
              onTap: () {},
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total:$totalPrice Tk",
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppButton(
                label: "Add to cart",
                onTap: () {
                  ShopProvider.of(context).addToCart(p: widget.model, counter: itemCount);
                  context.pop();
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            clipBehavior: Clip.none,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList.list(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 12,
                      child: Image.network(
                        widget.model.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const ImageErrorView(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: ItemCounter(
                        initialValue: itemCount,
                        onChanged: (v) {
                          itemCount = v;
                          setState(() {});
                        },
                      ),
                    ),
                    ProductDescription(model: widget.model),
                    const SizedBox(height: 24),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';

class AuthBackGroundWrapper extends StatelessWidget {
  const AuthBackGroundWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    const path = "assets/images/top_banner_fruits.png";

    const gap = SizedBox(height: 24);
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.white),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Image.asset(
            path,
            fit: BoxFit.fitWidth,
          ),
        ),
        Align(alignment: Alignment.topCenter, child: AppBar()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -4),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: AppTheme.background,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24)
                    .copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom),
                child: Column(
                  children: [
                    gap,
                    FractionallySizedBox(
                      widthFactor: .5,
                      child: Container(
                        height: 4,
                        decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    gap,
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



import 'package:flutter/material.dart';
import '../../app/route_config.dart';
import '../_common/widgets/background_view.dart';

import '../_common/widgets/app_button.dart';

class LoginOptionSelectionPage extends StatelessWidget {
  const LoginOptionSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BackgroundView.two(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        "Grocery shopping has never been this much fun ",
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppButton.large(
                            onTap: () {
                              context.push(AppRoute.signIn);
                            },
                            label: "Login",
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Don't Have an account",
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          AppButton.large(
                            onTap: () {
                              context.push(AppRoute.signUp);
                            },
                            label: "Sign Up",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  "assets/images/bottom_ve.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/src/app/route_config.dart';
import 'package:grocery_app/src/app/utils/input_validator.dart';
import 'package:grocery_app/src/presentation/auth/auth.dart';
import 'package:grocery_app/src/presentation/auth/widgets/already_account.dart';
import 'package:grocery_app/src/service/firebase_auth.dart';
import '../_common/widgets/app_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    return AuthBackGroundWrapper(
      title: "Create an account now",
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
                controller: _nameController,
                hint: "Name",
                icon: const Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name required";
                  } else if (!InputValidator.isValidName(value)) {
                    return "Enter your valid name";
                  }
                  return null;
                }),
            gap,
            AppTextField(
                controller: _emailController,
                hint: "Email",
                icon: const Icon(Icons.email_outlined),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email required";
                  } else if (!InputValidator.isValidEmail(value)) {
                    return "Enter your valid Email";
                  }
                  return null;
                }),
            gap,
            AppTextField(
                controller: _passwordController,
                hint: "Password",
                obscureText: true,
                icon: const Icon(Icons.lock),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password required";
                  } else if (!InputValidator.isValidPassword(value)) {
                    return "Enter your valid password";
                  }
                  return null;
                }),
            gap,
            AppTextField(
              controller: _cPasswordController,
              hint: "Confirm Password",
              obscureText: true,
              icon: const Icon(Icons.lock),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please confirm your password";
                }
                if (value != _passwordController.text) {
                  return "Passwords do not match";
                }
                return null;
              },
            ),
            gap,
            const SingInOptionView(),
            gap,
            gap,
            FractionallySizedBox(
              widthFactor: .75,
              child: SizedBox(
                height: 56,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.red,
                      ))
                    : ElevatedButton(
                        onPressed: _signUp,
                        child: const Text("Sign Up"),
                      ),
              ),
            ),
            gap,
            const AlreadyHaveAnAccountView(),
            gap,
          ],
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    final _authService = FirebaseAuthService();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      final error = await _authService.signUp(email, password);

      setState(() {
        _isLoading = false;
      });

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Sign up failed'),
          ),
        );
      } else {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'name': name,
            'email': email,
            'createdAt': Timestamp.now(),
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed up successfully!')),
        );
        context.push(AppRoute.signIn);
      }
    }
  }
}
import 'package:flutter/material.dart';
import '../../app/route_config.dart';

import '../_common/widgets/app_text_field.dart';
import 'auth.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    final textTheme = Theme.of(context).textTheme;
    return AuthBackGroundWrapper(
      title: "Verification",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Enter your email here ! we will send you verification code.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          const AppTextField(
            hint: "Email",
            icon: Icon(Icons.email),
          ),
          const SizedBox(height: 32),
          FractionallySizedBox(
            widthFactor: .75,
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  context.push(AppRoute.otp);
                },
                child: const Text("Send Code"),
              ),
            ),
          ),
          gap,
        ],
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/utils/input_validator.dart';
import 'package:grocery_app/src/presentation/auth/auth.dart';
import 'package:grocery_app/src/service/firebase_auth.dart';
import 'package:grocery_app/src/service/shared_pref.dart';
import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../_common/widgets/app_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);

    return AuthBackGroundWrapper(
      title: "Welcome back!",
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            gap,
            AppTextField(
              controller: _emailController,
              hint: "Email",
              icon: const Icon(Icons.email),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                } else if (!InputValidator.isValidEmail(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            gap,
            AppTextField(
              controller: _passwordController,
              hint: "Password",
              obscureText: true,
              icon: const Icon(Icons.lock),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                } else if (!InputValidator.isValidPassword(value)) {
                  return 'Enter a valid password';
                }
                return null;
              },
            ),
            gap,
            TextButton(
              onPressed: () {
                context.push(AppRoute.resetPassword);
              },
              child: const Text("Forgot password?"),
            ),
            gap,
            const SingInOptionView(),
            const SizedBox(height: 32),
            FractionallySizedBox(
              widthFactor: .75,
              child: SizedBox(
                height: 56,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text("Sign In"),
                      ),
              ),
            ),
            gap,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don’t have an account? "),
                InkWell(
                  onTap: () {
                    context.pushReplacement(AppRoute.signUp);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: AppTheme.primary),
                    ),
                  ),
                ),
              ],
            ),
            gap,
          ],
        ),
      ),
    );
  }

  void _login() async {
  final _authService = FirebaseAuthService();
  if (_formKey.currentState!.validate()) {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    final error = await _authService.signIn(email, password);

    setState(() {
      _isLoading = false;
    });

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Sign in failed'),
        ),
      );
    } else {
      final user = FirebaseAuth.instance.currentUser;
      
      if (user != null) {
        final userEmail = user.email;
        final userName = await _fetchUserNameFromFirestore(user.uid);
        if (userEmail != null) {
          await SharedPrefService.setUserEmail(userEmail);
        }
        if (userName != null) {
          await SharedPrefService.setUserName(userName);
        }
        await SharedPrefService.setLoginStatus(true);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed in successfully!')),
        );
        context.pushReplacement(AppRoute.home);
      }
    }
  }
}
Future<String?> _fetchUserNameFromFirestore(String uid) async {
  try {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userDoc.exists) {
      return userDoc.data()?['name'];
    }
  } catch (e) {
    print("Error fetching user name: $e");
  }
  return null;
}
  
}
import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';

class SingInOptionView extends StatelessWidget {
  const SingInOptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Or",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            Icons.facebook,
            Icons.g_mobiledata,
            Icons.inbox,
          ]
              .map(
                (e) => Card(
                  shape: const CircleBorder(),
                  elevation: 4,
                  child: IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF5C5C5C),
                      shadowColor: Colors.green,
                    ),
                    onPressed: () {},
                    icon: Icon(e),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAgcBrr3ZmsQ_MkCeJpuDudVm_U8f5diT4',
    appId: '1:665270910955:web:5e2b5df4f3d7070feb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    authDomain: 'nectar-5294a.firebaseapp.com',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    measurementId: 'G-HQK62DCV9D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXevK09S24HiAHuqsMz-x66Enlg_t31O4',
    appId: '1:665270910955:android:ba9a1df018aec47feb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAj24GfjsjWpT1GrcwyIN0MLYjOd9U-pcA',
    appId: '1:665270910955:ios:8bea429294a76a55eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    iosBundleId: 'com.example.groceryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAj24GfjsjWpT1GrcwyIN0MLYjOd9U-pcA',
    appId: '1:665270910955:ios:8bea429294a76a55eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    iosBundleId: 'com.example.groceryApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAgcBrr3ZmsQ_MkCeJpuDudVm_U8f5diT4',
    appId: '1:665270910955:web:5a63b11252913007eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    authDomain: 'nectar-5294a.firebaseapp.com',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    measurementId: 'G-1LNFZ1PJ2J',
  );
}
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'src/app/nectar_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const NectarApp(),
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/app_theme.dart';
import 'package:grocery_app/src/app/route_config.dart';

class AlreadyHaveAnAccountView extends StatelessWidget {
  const AlreadyHaveAnAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?"),
        InkWell(
          onTap: () {
            context.pushReplacement(AppRoute.signIn);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 4, right: 8, top: 8, bottom: 8),
            child: Text(
              "Login",
              style: TextStyle(color: AppTheme.primary),
            ),
          ),
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../_common/_common.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const gap = SizedBox(height: 32);

    return BackgroundView.single(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 64,
                right: 0,
                left: 0,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    "assets/images/landing_fruits.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Positioned(
                left: 24,
                right: 24,
                bottom: 64,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Buy ",
                        children: [
                          TextSpan(
                            text: "Grocery",
                            style: textTheme.headlineLarge?.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                          const TextSpan(text: " items easily with us")
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: textTheme.headlineLarge?.copyWith(),
                    ),
                    gap,
                    const Text(
                      "If you keep good food in your fridge, you will eat good food",
                      textAlign: TextAlign.center,
                    ),
                    gap,
                    AppButton.large(
                      onTap: () {
                        context.push(AppRoute.loginOption);
                      },
                      label: "Get Started",
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
lib/src/presentation/auth/widgets/background_auth_wrapper.dart
import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';

class AuthBackGroundWrapper extends StatelessWidget {
  const AuthBackGroundWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    const path = "assets/images/top_banner_fruits.png";

    const gap = SizedBox(height: 24);
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.white),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Image.asset(
            path,
            fit: BoxFit.fitWidth,
          ),
        ),
        Align(alignment: Alignment.topCenter, child: AppBar()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -4),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: AppTheme.background,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24)
                    .copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom),
                child: Column(
                  children: [
                    gap,
                    FractionallySizedBox(
                      widthFactor: .5,
                      child: Container(
                        height: 4,
                        decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    gap,
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
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
import 'package:flutter/material.dart';
import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../../infrastructure/infrastructure.dart';
import '../_common/_common.dart';
import 'widgets/product_description.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.model,
  });

  final ProductModel model;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int itemCount = 1;

  @override
  void initState() {
    super.initState();
    itemCount = widget.model.orderCounter;
  }

  String get totalPrice => (widget.model.price * itemCount).toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BackgroundView.triple(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: context.pop,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppTheme.borderColor,
            ),
          ),
          actions: [
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.shopping_cart_rounded,
                  color: AppTheme.primary,
                ),
              ),
              onTap: () {},
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total:$totalPrice Tk",
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppButton(
                label: "Add to cart",
                onTap: () {
                  ShopProvider.of(context).addToCart(p: widget.model, counter: itemCount);
                  context.pop();
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            clipBehavior: Clip.none,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList.list(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 12,
                      child: Image.network(
                        widget.model.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const ImageErrorView(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: ItemCounter(
                        initialValue: itemCount,
                        onChanged: (v) {
                          itemCount = v;
                          setState(() {});
                        },
                      ),
                    ),
                    ProductDescription(model: widget.model),
                    const SizedBox(height: 24),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';

class AuthBackGroundWrapper extends StatelessWidget {
  const AuthBackGroundWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    const path = "assets/images/top_banner_fruits.png";

    const gap = SizedBox(height: 24);
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.white),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Image.asset(
            path,
            fit: BoxFit.fitWidth,
          ),
        ),
        Align(alignment: Alignment.topCenter, child: AppBar()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -4),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: AppTheme.background,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24)
                    .copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom),
                child: Column(
                  children: [
                    gap,
                    FractionallySizedBox(
                      widthFactor: .5,
                      child: Container(
                        height: 4,
                        decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    gap,
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



import 'package:flutter/material.dart';
import '../../app/route_config.dart';
import '../_common/widgets/background_view.dart';

import '../_common/widgets/app_button.dart';

class LoginOptionSelectionPage extends StatelessWidget {
  const LoginOptionSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BackgroundView.two(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        "Grocery shopping has never been this much fun ",
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppButton.large(
                            onTap: () {
                              context.push(AppRoute.signIn);
                            },
                            label: "Login",
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Don't Have an account",
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          AppButton.large(
                            onTap: () {
                              context.push(AppRoute.signUp);
                            },
                            label: "Sign Up",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  "assets/images/bottom_ve.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/src/app/route_config.dart';
import 'package:grocery_app/src/app/utils/input_validator.dart';
import 'package:grocery_app/src/presentation/auth/auth.dart';
import 'package:grocery_app/src/presentation/auth/widgets/already_account.dart';
import 'package:grocery_app/src/service/firebase_auth.dart';
import '../_common/widgets/app_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    return AuthBackGroundWrapper(
      title: "Create an account now",
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
                controller: _nameController,
                hint: "Name",
                icon: const Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name required";
                  } else if (!InputValidator.isValidName(value)) {
                    return "Enter your valid name";
                  }
                  return null;
                }),
            gap,
            AppTextField(
                controller: _emailController,
                hint: "Email",
                icon: const Icon(Icons.email_outlined),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email required";
                  } else if (!InputValidator.isValidEmail(value)) {
                    return "Enter your valid Email";
                  }
                  return null;
                }),
            gap,
            AppTextField(
                controller: _passwordController,
                hint: "Password",
                obscureText: true,
                icon: const Icon(Icons.lock),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password required";
                  } else if (!InputValidator.isValidPassword(value)) {
                    return "Enter your valid password";
                  }
                  return null;
                }),
            gap,
            AppTextField(
              controller: _cPasswordController,
              hint: "Confirm Password",
              obscureText: true,
              icon: const Icon(Icons.lock),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please confirm your password";
                }
                if (value != _passwordController.text) {
                  return "Passwords do not match";
                }
                return null;
              },
            ),
            gap,
            const SingInOptionView(),
            gap,
            gap,
            FractionallySizedBox(
              widthFactor: .75,
              child: SizedBox(
                height: 56,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.red,
                      ))
                    : ElevatedButton(
                        onPressed: _signUp,
                        child: const Text("Sign Up"),
                      ),
              ),
            ),
            gap,
            const AlreadyHaveAnAccountView(),
            gap,
          ],
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    final _authService = FirebaseAuthService();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      final error = await _authService.signUp(email, password);

      setState(() {
        _isLoading = false;
      });

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Sign up failed'),
          ),
        );
      } else {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'name': name,
            'email': email,
            'createdAt': Timestamp.now(),
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed up successfully!')),
        );
        context.push(AppRoute.signIn);
      }
    }
  }
}
import 'package:flutter/material.dart';
import '../../app/route_config.dart';

import '../_common/widgets/app_text_field.dart';
import 'auth.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    final textTheme = Theme.of(context).textTheme;
    return AuthBackGroundWrapper(
      title: "Verification",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Enter your email here ! we will send you verification code.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          const AppTextField(
            hint: "Email",
            icon: Icon(Icons.email),
          ),
          const SizedBox(height: 32),
          FractionallySizedBox(
            widthFactor: .75,
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  context.push(AppRoute.otp);
                },
                child: const Text("Send Code"),
              ),
            ),
          ),
          gap,
        ],
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/utils/input_validator.dart';
import 'package:grocery_app/src/presentation/auth/auth.dart';
import 'package:grocery_app/src/service/firebase_auth.dart';
import 'package:grocery_app/src/service/shared_pref.dart';
import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../_common/widgets/app_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);

    return AuthBackGroundWrapper(
      title: "Welcome back!",
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            gap,
            AppTextField(
              controller: _emailController,
              hint: "Email",
              icon: const Icon(Icons.email),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                } else if (!InputValidator.isValidEmail(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            gap,
            AppTextField(
              controller: _passwordController,
              hint: "Password",
              obscureText: true,
              icon: const Icon(Icons.lock),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                } else if (!InputValidator.isValidPassword(value)) {
                  return 'Enter a valid password';
                }
                return null;
              },
            ),
            gap,
            TextButton(
              onPressed: () {
                context.push(AppRoute.resetPassword);
              },
              child: const Text("Forgot password?"),
            ),
            gap,
            const SingInOptionView(),
            const SizedBox(height: 32),
            FractionallySizedBox(
              widthFactor: .75,
              child: SizedBox(
                height: 56,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text("Sign In"),
                      ),
              ),
            ),
            gap,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don’t have an account? "),
                InkWell(
                  onTap: () {
                    context.pushReplacement(AppRoute.signUp);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: AppTheme.primary),
                    ),
                  ),
                ),
              ],
            ),
            gap,
          ],
        ),
      ),
    );
  }

  void _login() async {
  final _authService = FirebaseAuthService();
  if (_formKey.currentState!.validate()) {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    final error = await _authService.signIn(email, password);

    setState(() {
      _isLoading = false;
    });

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Sign in failed'),
        ),
      );
    } else {
      final user = FirebaseAuth.instance.currentUser;
      
      if (user != null) {
        final userEmail = user.email;
        final userName = await _fetchUserNameFromFirestore(user.uid);
        if (userEmail != null) {
          await SharedPrefService.setUserEmail(userEmail);
        }
        if (userName != null) {
          await SharedPrefService.setUserName(userName);
        }
        await SharedPrefService.setLoginStatus(true);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed in successfully!')),
        );
        context.pushReplacement(AppRoute.home);
      }
    }
  }
}
Future<String?> _fetchUserNameFromFirestore(String uid) async {
  try {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userDoc.exists) {
      return userDoc.data()?['name'];
    }
  } catch (e) {
    print("Error fetching user name: $e");
  }
  return null;
}
  
}
import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';

class SingInOptionView extends StatelessWidget {
  const SingInOptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Or",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            Icons.facebook,
            Icons.g_mobiledata,
            Icons.inbox,
          ]
              .map(
                (e) => Card(
                  shape: const CircleBorder(),
                  elevation: 4,
                  child: IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF5C5C5C),
                      shadowColor: Colors.green,
                    ),
                    onPressed: () {},
                    icon: Icon(e),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAgcBrr3ZmsQ_MkCeJpuDudVm_U8f5diT4',
    appId: '1:665270910955:web:5e2b5df4f3d7070feb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    authDomain: 'nectar-5294a.firebaseapp.com',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    measurementId: 'G-HQK62DCV9D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXevK09S24HiAHuqsMz-x66Enlg_t31O4',
    appId: '1:665270910955:android:ba9a1df018aec47feb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAj24GfjsjWpT1GrcwyIN0MLYjOd9U-pcA',
    appId: '1:665270910955:ios:8bea429294a76a55eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    iosBundleId: 'com.example.groceryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAj24GfjsjWpT1GrcwyIN0MLYjOd9U-pcA',
    appId: '1:665270910955:ios:8bea429294a76a55eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    iosBundleId: 'com.example.groceryApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAgcBrr3ZmsQ_MkCeJpuDudVm_U8f5diT4',
    appId: '1:665270910955:web:5a63b11252913007eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    authDomain: 'nectar-5294a.firebaseapp.com',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    measurementId: 'G-1LNFZ1PJ2J',
  );
}
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'src/app/nectar_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const NectarApp(),
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/app_theme.dart';
import 'package:grocery_app/src/app/route_config.dart';

class AlreadyHaveAnAccountView extends StatelessWidget {
  const AlreadyHaveAnAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?"),
        InkWell(
          onTap: () {
            context.pushReplacement(AppRoute.signIn);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 4, right: 8, top: 8, bottom: 8),
            child: Text(
              "Login",
              style: TextStyle(color: AppTheme.primary),
            ),
          ),
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../_common/_common.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const gap = SizedBox(height: 32);

    return BackgroundView.single(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 64,
                right: 0,
                left: 0,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    "assets/images/landing_fruits.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Positioned(
                left: 24,
                right: 24,
                bottom: 64,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Buy ",
                        children: [
                          TextSpan(
                            text: "Grocery",
                            style: textTheme.headlineLarge?.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                          const TextSpan(text: " items easily with us")
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: textTheme.headlineLarge?.copyWith(),
                    ),
                    gap,
                    const Text(
                      "If you keep good food in your fridge, you will eat good food",
                      textAlign: TextAlign.center,
                    ),
                    gap,
                    AppButton.large(
                      onTap: () {
                        context.push(AppRoute.loginOption);
                      },
                      label: "Get Started",
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
lib/src/presentation/auth/widgets/background_auth_wrapper.dart
import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';

class AuthBackGroundWrapper extends StatelessWidget {
  const AuthBackGroundWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    const path = "assets/images/top_banner_fruits.png";

    const gap = SizedBox(height: 24);
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.white),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Image.asset(
            path,
            fit: BoxFit.fitWidth,
          ),
        ),
        Align(alignment: Alignment.topCenter, child: AppBar()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -4),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: AppTheme.background,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24)
                    .copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom),
                child: Column(
                  children: [
                    gap,
                    FractionallySizedBox(
                      widthFactor: .5,
                      child: Container(
                        height: 4,
                        decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    gap,
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
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
import 'package:flutter/material.dart';
import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../../infrastructure/infrastructure.dart';
import '../_common/_common.dart';
import 'widgets/product_description.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.model,
  });

  final ProductModel model;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int itemCount = 1;

  @override
  void initState() {
    super.initState();
    itemCount = widget.model.orderCounter;
  }

  String get totalPrice => (widget.model.price * itemCount).toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BackgroundView.triple(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: context.pop,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppTheme.borderColor,
            ),
          ),
          actions: [
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.shopping_cart_rounded,
                  color: AppTheme.primary,
                ),
              ),
              onTap: () {},
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total:$totalPrice Tk",
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppButton(
                label: "Add to cart",
                onTap: () {
                  ShopProvider.of(context).addToCart(p: widget.model, counter: itemCount);
                  context.pop();
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            clipBehavior: Clip.none,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList.list(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 12,
                      child: Image.network(
                        widget.model.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const ImageErrorView(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: ItemCounter(
                        initialValue: itemCount,
                        onChanged: (v) {
                          itemCount = v;
                          setState(() {});
                        },
                      ),
                    ),
                    ProductDescription(model: widget.model),
                    const SizedBox(height: 24),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';

class AuthBackGroundWrapper extends StatelessWidget {
  const AuthBackGroundWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    const path = "assets/images/top_banner_fruits.png";

    const gap = SizedBox(height: 24);
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.white),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Image.asset(
            path,
            fit: BoxFit.fitWidth,
          ),
        ),
        Align(alignment: Alignment.topCenter, child: AppBar()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -4),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: AppTheme.background,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24)
                    .copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom),
                child: Column(
                  children: [
                    gap,
                    FractionallySizedBox(
                      widthFactor: .5,
                      child: Container(
                        height: 4,
                        decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    gap,
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



import 'package:flutter/material.dart';
import '../../app/route_config.dart';
import '../_common/widgets/background_view.dart';

import '../_common/widgets/app_button.dart';

class LoginOptionSelectionPage extends StatelessWidget {
  const LoginOptionSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BackgroundView.two(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        "Grocery shopping has never been this much fun ",
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppButton.large(
                            onTap: () {
                              context.push(AppRoute.signIn);
                            },
                            label: "Login",
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Don't Have an account",
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          AppButton.large(
                            onTap: () {
                              context.push(AppRoute.signUp);
                            },
                            label: "Sign Up",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  "assets/images/bottom_ve.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/src/app/route_config.dart';
import 'package:grocery_app/src/app/utils/input_validator.dart';
import 'package:grocery_app/src/presentation/auth/auth.dart';
import 'package:grocery_app/src/presentation/auth/widgets/already_account.dart';
import 'package:grocery_app/src/service/firebase_auth.dart';
import '../_common/widgets/app_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    return AuthBackGroundWrapper(
      title: "Create an account now",
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
                controller: _nameController,
                hint: "Name",
                icon: const Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name required";
                  } else if (!InputValidator.isValidName(value)) {
                    return "Enter your valid name";
                  }
                  return null;
                }),
            gap,
            AppTextField(
                controller: _emailController,
                hint: "Email",
                icon: const Icon(Icons.email_outlined),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email required";
                  } else if (!InputValidator.isValidEmail(value)) {
                    return "Enter your valid Email";
                  }
                  return null;
                }),
            gap,
            AppTextField(
                controller: _passwordController,
                hint: "Password",
                obscureText: true,
                icon: const Icon(Icons.lock),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password required";
                  } else if (!InputValidator.isValidPassword(value)) {
                    return "Enter your valid password";
                  }
                  return null;
                }),
            gap,
            AppTextField(
              controller: _cPasswordController,
              hint: "Confirm Password",
              obscureText: true,
              icon: const Icon(Icons.lock),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please confirm your password";
                }
                if (value != _passwordController.text) {
                  return "Passwords do not match";
                }
                return null;
              },
            ),
            gap,
            const SingInOptionView(),
            gap,
            gap,
            FractionallySizedBox(
              widthFactor: .75,
              child: SizedBox(
                height: 56,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.red,
                      ))
                    : ElevatedButton(
                        onPressed: _signUp,
                        child: const Text("Sign Up"),
                      ),
              ),
            ),
            gap,
            const AlreadyHaveAnAccountView(),
            gap,
          ],
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    final _authService = FirebaseAuthService();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      final error = await _authService.signUp(email, password);

      setState(() {
        _isLoading = false;
      });

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Sign up failed'),
          ),
        );
      } else {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'name': name,
            'email': email,
            'createdAt': Timestamp.now(),
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed up successfully!')),
        );
        context.push(AppRoute.signIn);
      }
    }
  }
}
import 'package:flutter/material.dart';
import '../../app/route_config.dart';

import '../_common/widgets/app_text_field.dart';
import 'auth.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    final textTheme = Theme.of(context).textTheme;
    return AuthBackGroundWrapper(
      title: "Verification",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Enter your email here ! we will send you verification code.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          const AppTextField(
            hint: "Email",
            icon: Icon(Icons.email),
          ),
          const SizedBox(height: 32),
          FractionallySizedBox(
            widthFactor: .75,
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  context.push(AppRoute.otp);
                },
                child: const Text("Send Code"),
              ),
            ),
          ),
          gap,
        ],
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/utils/input_validator.dart';
import 'package:grocery_app/src/presentation/auth/auth.dart';
import 'package:grocery_app/src/service/firebase_auth.dart';
import 'package:grocery_app/src/service/shared_pref.dart';
import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../_common/widgets/app_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);

    return AuthBackGroundWrapper(
      title: "Welcome back!",
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            gap,
            AppTextField(
              controller: _emailController,
              hint: "Email",
              icon: const Icon(Icons.email),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                } else if (!InputValidator.isValidEmail(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            gap,
            AppTextField(
              controller: _passwordController,
              hint: "Password",
              obscureText: true,
              icon: const Icon(Icons.lock),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                } else if (!InputValidator.isValidPassword(value)) {
                  return 'Enter a valid password';
                }
                return null;
              },
            ),
            gap,
            TextButton(
              onPressed: () {
                context.push(AppRoute.resetPassword);
              },
              child: const Text("Forgot password?"),
            ),
            gap,
            const SingInOptionView(),
            const SizedBox(height: 32),
            FractionallySizedBox(
              widthFactor: .75,
              child: SizedBox(
                height: 56,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text("Sign In"),
                      ),
              ),
            ),
            gap,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don’t have an account? "),
                InkWell(
                  onTap: () {
                    context.pushReplacement(AppRoute.signUp);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: AppTheme.primary),
                    ),
                  ),
                ),
              ],
            ),
            gap,
          ],
        ),
      ),
    );
  }

  void _login() async {
  final _authService = FirebaseAuthService();
  if (_formKey.currentState!.validate()) {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    final error = await _authService.signIn(email, password);

    setState(() {
      _isLoading = false;
    });

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Sign in failed'),
        ),
      );
    } else {
      final user = FirebaseAuth.instance.currentUser;
      
      if (user != null) {
        final userEmail = user.email;
        final userName = await _fetchUserNameFromFirestore(user.uid);
        if (userEmail != null) {
          await SharedPrefService.setUserEmail(userEmail);
        }
        if (userName != null) {
          await SharedPrefService.setUserName(userName);
        }
        await SharedPrefService.setLoginStatus(true);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed in successfully!')),
        );
        context.pushReplacement(AppRoute.home);
      }
    }
  }
}
Future<String?> _fetchUserNameFromFirestore(String uid) async {
  try {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userDoc.exists) {
      return userDoc.data()?['name'];
    }
  } catch (e) {
    print("Error fetching user name: $e");
  }
  return null;
}
  
}
import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';

class SingInOptionView extends StatelessWidget {
  const SingInOptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Or",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            Icons.facebook,
            Icons.g_mobiledata,
            Icons.inbox,
          ]
              .map(
                (e) => Card(
                  shape: const CircleBorder(),
                  elevation: 4,
                  child: IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF5C5C5C),
                      shadowColor: Colors.green,
                    ),
                    onPressed: () {},
                    icon: Icon(e),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAgcBrr3ZmsQ_MkCeJpuDudVm_U8f5diT4',
    appId: '1:665270910955:web:5e2b5df4f3d7070feb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    authDomain: 'nectar-5294a.firebaseapp.com',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    measurementId: 'G-HQK62DCV9D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXevK09S24HiAHuqsMz-x66Enlg_t31O4',
    appId: '1:665270910955:android:ba9a1df018aec47feb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAj24GfjsjWpT1GrcwyIN0MLYjOd9U-pcA',
    appId: '1:665270910955:ios:8bea429294a76a55eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    iosBundleId: 'com.example.groceryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAj24GfjsjWpT1GrcwyIN0MLYjOd9U-pcA',
    appId: '1:665270910955:ios:8bea429294a76a55eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    iosBundleId: 'com.example.groceryApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAgcBrr3ZmsQ_MkCeJpuDudVm_U8f5diT4',
    appId: '1:665270910955:web:5a63b11252913007eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    authDomain: 'nectar-5294a.firebaseapp.com',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    measurementId: 'G-1LNFZ1PJ2J',
  );
}
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'src/app/nectar_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const NectarApp(),
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/app_theme.dart';
import 'package:grocery_app/src/app/route_config.dart';

class AlreadyHaveAnAccountView extends StatelessWidget {
  const AlreadyHaveAnAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?"),
        InkWell(
          onTap: () {
            context.pushReplacement(AppRoute.signIn);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 4, right: 8, top: 8, bottom: 8),
            child: Text(
              "Login",
              style: TextStyle(color: AppTheme.primary),
            ),
          ),
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../_common/_common.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const gap = SizedBox(height: 32);

    return BackgroundView.single(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 64,
                right: 0,
                left: 0,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    "assets/images/landing_fruits.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Positioned(
                left: 24,
                right: 24,
                bottom: 64,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Buy ",
                        children: [
                          TextSpan(
                            text: "Grocery",
                            style: textTheme.headlineLarge?.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                          const TextSpan(text: " items easily with us")
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: textTheme.headlineLarge?.copyWith(),
                    ),
                    gap,
                    const Text(
                      "If you keep good food in your fridge, you will eat good food",
                      textAlign: TextAlign.center,
                    ),
                    gap,
                    AppButton.large(
                      onTap: () {
                        context.push(AppRoute.loginOption);
                      },
                      label: "Get Started",
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
lib/src/presentation/auth/widgets/background_auth_wrapper.dart
import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';

class AuthBackGroundWrapper extends StatelessWidget {
  const AuthBackGroundWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    const path = "assets/images/top_banner_fruits.png";

    const gap = SizedBox(height: 24);
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.white),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Image.asset(
            path,
            fit: BoxFit.fitWidth,
          ),
        ),
        Align(alignment: Alignment.topCenter, child: AppBar()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -4),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: AppTheme.background,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24)
                    .copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom),
                child: Column(
                  children: [
                    gap,
                    FractionallySizedBox(
                      widthFactor: .5,
                      child: Container(
                        height: 4,
                        decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    gap,
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
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
import 'package:flutter/material.dart';
import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../../infrastructure/infrastructure.dart';
import '../_common/_common.dart';
import 'widgets/product_description.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.model,
  });

  final ProductModel model;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int itemCount = 1;

  @override
  void initState() {
    super.initState();
    itemCount = widget.model.orderCounter;
  }

  String get totalPrice => (widget.model.price * itemCount).toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BackgroundView.triple(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: context.pop,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppTheme.borderColor,
            ),
          ),
          actions: [
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.shopping_cart_rounded,
                  color: AppTheme.primary,
                ),
              ),
              onTap: () {},
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total:$totalPrice Tk",
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppButton(
                label: "Add to cart",
                onTap: () {
                  ShopProvider.of(context).addToCart(p: widget.model, counter: itemCount);
                  context.pop();
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            clipBehavior: Clip.none,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList.list(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 12,
                      child: Image.network(
                        widget.model.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const ImageErrorView(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: ItemCounter(
                        initialValue: itemCount,
                        onChanged: (v) {
                          itemCount = v;
                          setState(() {});
                        },
                      ),
                    ),
                    ProductDescription(model: widget.model),
                    const SizedBox(height: 24),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';

class AuthBackGroundWrapper extends StatelessWidget {
  const AuthBackGroundWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    const path = "assets/images/top_banner_fruits.png";

    const gap = SizedBox(height: 24);
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.white),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Image.asset(
            path,
            fit: BoxFit.fitWidth,
          ),
        ),
        Align(alignment: Alignment.topCenter, child: AppBar()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -4),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: AppTheme.background,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24)
                    .copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom),
                child: Column(
                  children: [
                    gap,
                    FractionallySizedBox(
                      widthFactor: .5,
                      child: Container(
                        height: 4,
                        decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    gap,
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



import 'package:flutter/material.dart';
import '../../app/route_config.dart';
import '../_common/widgets/background_view.dart';

import '../_common/widgets/app_button.dart';

class LoginOptionSelectionPage extends StatelessWidget {
  const LoginOptionSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BackgroundView.two(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        "Grocery shopping has never been this much fun ",
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppButton.large(
                            onTap: () {
                              context.push(AppRoute.signIn);
                            },
                            label: "Login",
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Don't Have an account",
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          AppButton.large(
                            onTap: () {
                              context.push(AppRoute.signUp);
                            },
                            label: "Sign Up",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  "assets/images/bottom_ve.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/src/app/route_config.dart';
import 'package:grocery_app/src/app/utils/input_validator.dart';
import 'package:grocery_app/src/presentation/auth/auth.dart';
import 'package:grocery_app/src/presentation/auth/widgets/already_account.dart';
import 'package:grocery_app/src/service/firebase_auth.dart';
import '../_common/widgets/app_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    return AuthBackGroundWrapper(
      title: "Create an account now",
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
                controller: _nameController,
                hint: "Name",
                icon: const Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name required";
                  } else if (!InputValidator.isValidName(value)) {
                    return "Enter your valid name";
                  }
                  return null;
                }),
            gap,
            AppTextField(
                controller: _emailController,
                hint: "Email",
                icon: const Icon(Icons.email_outlined),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email required";
                  } else if (!InputValidator.isValidEmail(value)) {
                    return "Enter your valid Email";
                  }
                  return null;
                }),
            gap,
            AppTextField(
                controller: _passwordController,
                hint: "Password",
                obscureText: true,
                icon: const Icon(Icons.lock),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password required";
                  } else if (!InputValidator.isValidPassword(value)) {
                    return "Enter your valid password";
                  }
                  return null;
                }),
            gap,
            AppTextField(
              controller: _cPasswordController,
              hint: "Confirm Password",
              obscureText: true,
              icon: const Icon(Icons.lock),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please confirm your password";
                }
                if (value != _passwordController.text) {
                  return "Passwords do not match";
                }
                return null;
              },
            ),
            gap,
            const SingInOptionView(),
            gap,
            gap,
            FractionallySizedBox(
              widthFactor: .75,
              child: SizedBox(
                height: 56,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.red,
                      ))
                    : ElevatedButton(
                        onPressed: _signUp,
                        child: const Text("Sign Up"),
                      ),
              ),
            ),
            gap,
            const AlreadyHaveAnAccountView(),
            gap,
          ],
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    final _authService = FirebaseAuthService();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      final error = await _authService.signUp(email, password);

      setState(() {
        _isLoading = false;
      });

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Sign up failed'),
          ),
        );
      } else {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'name': name,
            'email': email,
            'createdAt': Timestamp.now(),
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed up successfully!')),
        );
        context.push(AppRoute.signIn);
      }
    }
  }
}
import 'package:flutter/material.dart';
import '../../app/route_config.dart';

import '../_common/widgets/app_text_field.dart';
import 'auth.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    final textTheme = Theme.of(context).textTheme;
    return AuthBackGroundWrapper(
      title: "Verification",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Enter your email here ! we will send you verification code.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          const AppTextField(
            hint: "Email",
            icon: Icon(Icons.email),
          ),
          const SizedBox(height: 32),
          FractionallySizedBox(
            widthFactor: .75,
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  context.push(AppRoute.otp);
                },
                child: const Text("Send Code"),
              ),
            ),
          ),
          gap,
        ],
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/utils/input_validator.dart';
import 'package:grocery_app/src/presentation/auth/auth.dart';
import 'package:grocery_app/src/service/firebase_auth.dart';
import 'package:grocery_app/src/service/shared_pref.dart';
import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../_common/widgets/app_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);

    return AuthBackGroundWrapper(
      title: "Welcome back!",
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            gap,
            AppTextField(
              controller: _emailController,
              hint: "Email",
              icon: const Icon(Icons.email),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                } else if (!InputValidator.isValidEmail(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            gap,
            AppTextField(
              controller: _passwordController,
              hint: "Password",
              obscureText: true,
              icon: const Icon(Icons.lock),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                } else if (!InputValidator.isValidPassword(value)) {
                  return 'Enter a valid password';
                }
                return null;
              },
            ),
            gap,
            TextButton(
              onPressed: () {
                context.push(AppRoute.resetPassword);
              },
              child: const Text("Forgot password?"),
            ),
            gap,
            const SingInOptionView(),
            const SizedBox(height: 32),
            FractionallySizedBox(
              widthFactor: .75,
              child: SizedBox(
                height: 56,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text("Sign In"),
                      ),
              ),
            ),
            gap,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don’t have an account? "),
                InkWell(
                  onTap: () {
                    context.pushReplacement(AppRoute.signUp);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: AppTheme.primary),
                    ),
                  ),
                ),
              ],
            ),
            gap,
          ],
        ),
      ),
    );
  }

  void _login() async {
  final _authService = FirebaseAuthService();
  if (_formKey.currentState!.validate()) {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    final error = await _authService.signIn(email, password);

    setState(() {
      _isLoading = false;
    });

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Sign in failed'),
        ),
      );
    } else {
      final user = FirebaseAuth.instance.currentUser;
      
      if (user != null) {
        final userEmail = user.email;
        final userName = await _fetchUserNameFromFirestore(user.uid);
        if (userEmail != null) {
          await SharedPrefService.setUserEmail(userEmail);
        }
        if (userName != null) {
          await SharedPrefService.setUserName(userName);
        }
        await SharedPrefService.setLoginStatus(true);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed in successfully!')),
        );
        context.pushReplacement(AppRoute.home);
      }
    }
  }
}
Future<String?> _fetchUserNameFromFirestore(String uid) async {
  try {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userDoc.exists) {
      return userDoc.data()?['name'];
    }
  } catch (e) {
    print("Error fetching user name: $e");
  }
  return null;
}
  
}
import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';

class SingInOptionView extends StatelessWidget {
  const SingInOptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Or",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            Icons.facebook,
            Icons.g_mobiledata,
            Icons.inbox,
          ]
              .map(
                (e) => Card(
                  shape: const CircleBorder(),
                  elevation: 4,
                  child: IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF5C5C5C),
                      shadowColor: Colors.green,
                    ),
                    onPressed: () {},
                    icon: Icon(e),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAgcBrr3ZmsQ_MkCeJpuDudVm_U8f5diT4',
    appId: '1:665270910955:web:5e2b5df4f3d7070feb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    authDomain: 'nectar-5294a.firebaseapp.com',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    measurementId: 'G-HQK62DCV9D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXevK09S24HiAHuqsMz-x66Enlg_t31O4',
    appId: '1:665270910955:android:ba9a1df018aec47feb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAj24GfjsjWpT1GrcwyIN0MLYjOd9U-pcA',
    appId: '1:665270910955:ios:8bea429294a76a55eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    iosBundleId: 'com.example.groceryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAj24GfjsjWpT1GrcwyIN0MLYjOd9U-pcA',
    appId: '1:665270910955:ios:8bea429294a76a55eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    iosBundleId: 'com.example.groceryApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAgcBrr3ZmsQ_MkCeJpuDudVm_U8f5diT4',
    appId: '1:665270910955:web:5a63b11252913007eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    authDomain: 'nectar-5294a.firebaseapp.com',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    measurementId: 'G-1LNFZ1PJ2J',
  );
}
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'src/app/nectar_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const NectarApp(),
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/app_theme.dart';
import 'package:grocery_app/src/app/route_config.dart';

class AlreadyHaveAnAccountView extends StatelessWidget {
  const AlreadyHaveAnAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?"),
        InkWell(
          onTap: () {
            context.pushReplacement(AppRoute.signIn);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 4, right: 8, top: 8, bottom: 8),
            child: Text(
              "Login",
              style: TextStyle(color: AppTheme.primary),
            ),
          ),
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../_common/_common.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const gap = SizedBox(height: 32);

    return BackgroundView.single(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 64,
                right: 0,
                left: 0,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    "assets/images/landing_fruits.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Positioned(
                left: 24,
                right: 24,
                bottom: 64,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Buy ",
                        children: [
                          TextSpan(
                            text: "Grocery",
                            style: textTheme.headlineLarge?.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                          const TextSpan(text: " items easily with us")
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: textTheme.headlineLarge?.copyWith(),
                    ),
                    gap,
                    const Text(
                      "If you keep good food in your fridge, you will eat good food",
                      textAlign: TextAlign.center,
                    ),
                    gap,
                    AppButton.large(
                      onTap: () {
                        context.push(AppRoute.loginOption);
                      },
                      label: "Get Started",
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
lib/src/presentation/auth/widgets/background_auth_wrapper.dart
import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';

class AuthBackGroundWrapper extends StatelessWidget {
  const AuthBackGroundWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    const path = "assets/images/top_banner_fruits.png";

    const gap = SizedBox(height: 24);
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.white),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Image.asset(
            path,
            fit: BoxFit.fitWidth,
          ),
        ),
        Align(alignment: Alignment.topCenter, child: AppBar()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -4),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: AppTheme.background,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24)
                    .copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom),
                child: Column(
                  children: [
                    gap,
                    FractionallySizedBox(
                      widthFactor: .5,
                      child: Container(
                        height: 4,
                        decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    gap,
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
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
import 'package:flutter/material.dart';
import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../../infrastructure/infrastructure.dart';
import '../_common/_common.dart';
import 'widgets/product_description.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.model,
  });

  final ProductModel model;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int itemCount = 1;

  @override
  void initState() {
    super.initState();
    itemCount = widget.model.orderCounter;
  }

  String get totalPrice => (widget.model.price * itemCount).toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BackgroundView.triple(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: context.pop,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppTheme.borderColor,
            ),
          ),
          actions: [
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.shopping_cart_rounded,
                  color: AppTheme.primary,
                ),
              ),
              onTap: () {},
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total:$totalPrice Tk",
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppButton(
                label: "Add to cart",
                onTap: () {
                  ShopProvider.of(context).addToCart(p: widget.model, counter: itemCount);
                  context.pop();
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            clipBehavior: Clip.none,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList.list(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 12,
                      child: Image.network(
                        widget.model.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const ImageErrorView(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: ItemCounter(
                        initialValue: itemCount,
                        onChanged: (v) {
                          itemCount = v;
                          setState(() {});
                        },
                      ),
                    ),
                    ProductDescription(model: widget.model),
                    const SizedBox(height: 24),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';

class AuthBackGroundWrapper extends StatelessWidget {
  const AuthBackGroundWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    const path = "assets/images/top_banner_fruits.png";

    const gap = SizedBox(height: 24);
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.white),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Image.asset(
            path,
            fit: BoxFit.fitWidth,
          ),
        ),
        Align(alignment: Alignment.topCenter, child: AppBar()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -4),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: AppTheme.background,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24)
                    .copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom),
                child: Column(
                  children: [
                    gap,
                    FractionallySizedBox(
                      widthFactor: .5,
                      child: Container(
                        height: 4,
                        decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    gap,
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



import 'package:flutter/material.dart';
import '../../app/route_config.dart';
import '../_common/widgets/background_view.dart';

import '../_common/widgets/app_button.dart';

class LoginOptionSelectionPage extends StatelessWidget {
  const LoginOptionSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BackgroundView.two(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        "Grocery shopping has never been this much fun ",
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppButton.large(
                            onTap: () {
                              context.push(AppRoute.signIn);
                            },
                            label: "Login",
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Don't Have an account",
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          AppButton.large(
                            onTap: () {
                              context.push(AppRoute.signUp);
                            },
                            label: "Sign Up",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  "assets/images/bottom_ve.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/src/app/route_config.dart';
import 'package:grocery_app/src/app/utils/input_validator.dart';
import 'package:grocery_app/src/presentation/auth/auth.dart';
import 'package:grocery_app/src/presentation/auth/widgets/already_account.dart';
import 'package:grocery_app/src/service/firebase_auth.dart';
import '../_common/widgets/app_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    return AuthBackGroundWrapper(
      title: "Create an account now",
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
                controller: _nameController,
                hint: "Name",
                icon: const Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name required";
                  } else if (!InputValidator.isValidName(value)) {
                    return "Enter your valid name";
                  }
                  return null;
                }),
            gap,
            AppTextField(
                controller: _emailController,
                hint: "Email",
                icon: const Icon(Icons.email_outlined),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email required";
                  } else if (!InputValidator.isValidEmail(value)) {
                    return "Enter your valid Email";
                  }
                  return null;
                }),
            gap,
            AppTextField(
                controller: _passwordController,
                hint: "Password",
                obscureText: true,
                icon: const Icon(Icons.lock),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password required";
                  } else if (!InputValidator.isValidPassword(value)) {
                    return "Enter your valid password";
                  }
                  return null;
                }),
            gap,
            AppTextField(
              controller: _cPasswordController,
              hint: "Confirm Password",
              obscureText: true,
              icon: const Icon(Icons.lock),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please confirm your password";
                }
                if (value != _passwordController.text) {
                  return "Passwords do not match";
                }
                return null;
              },
            ),
            gap,
            const SingInOptionView(),
            gap,
            gap,
            FractionallySizedBox(
              widthFactor: .75,
              child: SizedBox(
                height: 56,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.red,
                      ))
                    : ElevatedButton(
                        onPressed: _signUp,
                        child: const Text("Sign Up"),
                      ),
              ),
            ),
            gap,
            const AlreadyHaveAnAccountView(),
            gap,
          ],
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    final _authService = FirebaseAuthService();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      final error = await _authService.signUp(email, password);

      setState(() {
        _isLoading = false;
      });

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Sign up failed'),
          ),
        );
      } else {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'name': name,
            'email': email,
            'createdAt': Timestamp.now(),
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed up successfully!')),
        );
        context.push(AppRoute.signIn);
      }
    }
  }
}
import 'package:flutter/material.dart';
import '../../app/route_config.dart';

import '../_common/widgets/app_text_field.dart';
import 'auth.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    final textTheme = Theme.of(context).textTheme;
    return AuthBackGroundWrapper(
      title: "Verification",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Enter your email here ! we will send you verification code.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          const AppTextField(
            hint: "Email",
            icon: Icon(Icons.email),
          ),
          const SizedBox(height: 32),
          FractionallySizedBox(
            widthFactor: .75,
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  context.push(AppRoute.otp);
                },
                child: const Text("Send Code"),
              ),
            ),
          ),
          gap,
        ],
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/utils/input_validator.dart';
import 'package:grocery_app/src/presentation/auth/auth.dart';
import 'package:grocery_app/src/service/firebase_auth.dart';
import 'package:grocery_app/src/service/shared_pref.dart';
import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../_common/widgets/app_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);

    return AuthBackGroundWrapper(
      title: "Welcome back!",
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            gap,
            AppTextField(
              controller: _emailController,
              hint: "Email",
              icon: const Icon(Icons.email),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                } else if (!InputValidator.isValidEmail(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            gap,
            AppTextField(
              controller: _passwordController,
              hint: "Password",
              obscureText: true,
              icon: const Icon(Icons.lock),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                } else if (!InputValidator.isValidPassword(value)) {
                  return 'Enter a valid password';
                }
                return null;
              },
            ),
            gap,
            TextButton(
              onPressed: () {
                context.push(AppRoute.resetPassword);
              },
              child: const Text("Forgot password?"),
            ),
            gap,
            const SingInOptionView(),
            const SizedBox(height: 32),
            FractionallySizedBox(
              widthFactor: .75,
              child: SizedBox(
                height: 56,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text("Sign In"),
                      ),
              ),
            ),
            gap,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don’t have an account? "),
                InkWell(
                  onTap: () {
                    context.pushReplacement(AppRoute.signUp);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: AppTheme.primary),
                    ),
                  ),
                ),
              ],
            ),
            gap,
          ],
        ),
      ),
    );
  }

  void _login() async {
  final _authService = FirebaseAuthService();
  if (_formKey.currentState!.validate()) {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    final error = await _authService.signIn(email, password);

    setState(() {
      _isLoading = false;
    });

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Sign in failed'),
        ),
      );
    } else {
      final user = FirebaseAuth.instance.currentUser;
      
      if (user != null) {
        final userEmail = user.email;
        final userName = await _fetchUserNameFromFirestore(user.uid);
        if (userEmail != null) {
          await SharedPrefService.setUserEmail(userEmail);
        }
        if (userName != null) {
          await SharedPrefService.setUserName(userName);
        }
        await SharedPrefService.setLoginStatus(true);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed in successfully!')),
        );
        context.pushReplacement(AppRoute.home);
      }
    }
  }
}
Future<String?> _fetchUserNameFromFirestore(String uid) async {
  try {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userDoc.exists) {
      return userDoc.data()?['name'];
    }
  } catch (e) {
    print("Error fetching user name: $e");
  }
  return null;
}
  
}
import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';

class SingInOptionView extends StatelessWidget {
  const SingInOptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Or",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            Icons.facebook,
            Icons.g_mobiledata,
            Icons.inbox,
          ]
              .map(
                (e) => Card(
                  shape: const CircleBorder(),
                  elevation: 4,
                  child: IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF5C5C5C),
                      shadowColor: Colors.green,
                    ),
                    onPressed: () {},
                    icon: Icon(e),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAgcBrr3ZmsQ_MkCeJpuDudVm_U8f5diT4',
    appId: '1:665270910955:web:5e2b5df4f3d7070feb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    authDomain: 'nectar-5294a.firebaseapp.com',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    measurementId: 'G-HQK62DCV9D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXevK09S24HiAHuqsMz-x66Enlg_t31O4',
    appId: '1:665270910955:android:ba9a1df018aec47feb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAj24GfjsjWpT1GrcwyIN0MLYjOd9U-pcA',
    appId: '1:665270910955:ios:8bea429294a76a55eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    iosBundleId: 'com.example.groceryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAj24GfjsjWpT1GrcwyIN0MLYjOd9U-pcA',
    appId: '1:665270910955:ios:8bea429294a76a55eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    iosBundleId: 'com.example.groceryApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAgcBrr3ZmsQ_MkCeJpuDudVm_U8f5diT4',
    appId: '1:665270910955:web:5a63b11252913007eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    authDomain: 'nectar-5294a.firebaseapp.com',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    measurementId: 'G-1LNFZ1PJ2J',
  );
}
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'src/app/nectar_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const NectarApp(),
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/app_theme.dart';
import 'package:grocery_app/src/app/route_config.dart';

class AlreadyHaveAnAccountView extends StatelessWidget {
  const AlreadyHaveAnAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?"),
        InkWell(
          onTap: () {
            context.pushReplacement(AppRoute.signIn);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 4, right: 8, top: 8, bottom: 8),
            child: Text(
              "Login",
              style: TextStyle(color: AppTheme.primary),
            ),
          ),
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../_common/_common.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const gap = SizedBox(height: 32);

    return BackgroundView.single(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 64,
                right: 0,
                left: 0,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    "assets/images/landing_fruits.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Positioned(
                left: 24,
                right: 24,
                bottom: 64,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Buy ",
                        children: [
                          TextSpan(
                            text: "Grocery",
                            style: textTheme.headlineLarge?.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                          const TextSpan(text: " items easily with us")
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: textTheme.headlineLarge?.copyWith(),
                    ),
                    gap,
                    const Text(
                      "If you keep good food in your fridge, you will eat good food",
                      textAlign: TextAlign.center,
                    ),
                    gap,
                    AppButton.large(
                      onTap: () {
                        context.push(AppRoute.loginOption);
                      },
                      label: "Get Started",
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
lib/src/presentation/auth/widgets/background_auth_wrapper.dart
import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';

class AuthBackGroundWrapper extends StatelessWidget {
  const AuthBackGroundWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    const path = "assets/images/top_banner_fruits.png";

    const gap = SizedBox(height: 24);
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.white),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Image.asset(
            path,
            fit: BoxFit.fitWidth,
          ),
        ),
        Align(alignment: Alignment.topCenter, child: AppBar()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -4),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: AppTheme.background,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24)
                    .copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom),
                child: Column(
                  children: [
                    gap,
                    FractionallySizedBox(
                      widthFactor: .5,
                      child: Container(
                        height: 4,
                        decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    gap,
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
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
import 'package:flutter/material.dart';
import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../../infrastructure/infrastructure.dart';
import '../_common/_common.dart';
import 'widgets/product_description.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.model,
  });

  final ProductModel model;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int itemCount = 1;

  @override
  void initState() {
    super.initState();
    itemCount = widget.model.orderCounter;
  }

  String get totalPrice => (widget.model.price * itemCount).toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BackgroundView.triple(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: context.pop,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppTheme.borderColor,
            ),
          ),
          actions: [
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.shopping_cart_rounded,
                  color: AppTheme.primary,
                ),
              ),
              onTap: () {},
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total:$totalPrice Tk",
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppButton(
                label: "Add to cart",
                onTap: () {
                  ShopProvider.of(context).addToCart(p: widget.model, counter: itemCount);
                  context.pop();
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            clipBehavior: Clip.none,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList.list(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 12,
                      child: Image.network(
                        widget.model.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const ImageErrorView(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: ItemCounter(
                        initialValue: itemCount,
                        onChanged: (v) {
                          itemCount = v;
                          setState(() {});
                        },
                      ),
                    ),
                    ProductDescription(model: widget.model),
                    const SizedBox(height: 24),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';

class AuthBackGroundWrapper extends StatelessWidget {
  const AuthBackGroundWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    const path = "assets/images/top_banner_fruits.png";

    const gap = SizedBox(height: 24);
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.white),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Image.asset(
            path,
            fit: BoxFit.fitWidth,
          ),
        ),
        Align(alignment: Alignment.topCenter, child: AppBar()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -4),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: AppTheme.background,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24)
                    .copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom),
                child: Column(
                  children: [
                    gap,
                    FractionallySizedBox(
                      widthFactor: .5,
                      child: Container(
                        height: 4,
                        decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    gap,
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



import 'package:flutter/material.dart';
import '../../app/route_config.dart';
import '../_common/widgets/background_view.dart';

import '../_common/widgets/app_button.dart';

class LoginOptionSelectionPage extends StatelessWidget {
  const LoginOptionSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BackgroundView.two(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        "Grocery shopping has never been this much fun ",
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppButton.large(
                            onTap: () {
                              context.push(AppRoute.signIn);
                            },
                            label: "Login",
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Don't Have an account",
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          AppButton.large(
                            onTap: () {
                              context.push(AppRoute.signUp);
                            },
                            label: "Sign Up",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  "assets/images/bottom_ve.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/src/app/route_config.dart';
import 'package:grocery_app/src/app/utils/input_validator.dart';
import 'package:grocery_app/src/presentation/auth/auth.dart';
import 'package:grocery_app/src/presentation/auth/widgets/already_account.dart';
import 'package:grocery_app/src/service/firebase_auth.dart';
import '../_common/widgets/app_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    return AuthBackGroundWrapper(
      title: "Create an account now",
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
                controller: _nameController,
                hint: "Name",
                icon: const Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name required";
                  } else if (!InputValidator.isValidName(value)) {
                    return "Enter your valid name";
                  }
                  return null;
                }),
            gap,
            AppTextField(
                controller: _emailController,
                hint: "Email",
                icon: const Icon(Icons.email_outlined),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email required";
                  } else if (!InputValidator.isValidEmail(value)) {
                    return "Enter your valid Email";
                  }
                  return null;
                }),
            gap,
            AppTextField(
                controller: _passwordController,
                hint: "Password",
                obscureText: true,
                icon: const Icon(Icons.lock),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password required";
                  } else if (!InputValidator.isValidPassword(value)) {
                    return "Enter your valid password";
                  }
                  return null;
                }),
            gap,
            AppTextField(
              controller: _cPasswordController,
              hint: "Confirm Password",
              obscureText: true,
              icon: const Icon(Icons.lock),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please confirm your password";
                }
                if (value != _passwordController.text) {
                  return "Passwords do not match";
                }
                return null;
              },
            ),
            gap,
            const SingInOptionView(),
            gap,
            gap,
            FractionallySizedBox(
              widthFactor: .75,
              child: SizedBox(
                height: 56,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.red,
                      ))
                    : ElevatedButton(
                        onPressed: _signUp,
                        child: const Text("Sign Up"),
                      ),
              ),
            ),
            gap,
            const AlreadyHaveAnAccountView(),
            gap,
          ],
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    final _authService = FirebaseAuthService();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      final error = await _authService.signUp(email, password);

      setState(() {
        _isLoading = false;
      });

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Sign up failed'),
          ),
        );
      } else {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'name': name,
            'email': email,
            'createdAt': Timestamp.now(),
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed up successfully!')),
        );
        context.push(AppRoute.signIn);
      }
    }
  }
}
import 'package:flutter/material.dart';
import '../../app/route_config.dart';

import '../_common/widgets/app_text_field.dart';
import 'auth.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    final textTheme = Theme.of(context).textTheme;
    return AuthBackGroundWrapper(
      title: "Verification",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Enter your email here ! we will send you verification code.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          const AppTextField(
            hint: "Email",
            icon: Icon(Icons.email),
          ),
          const SizedBox(height: 32),
          FractionallySizedBox(
            widthFactor: .75,
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  context.push(AppRoute.otp);
                },
                child: const Text("Send Code"),
              ),
            ),
          ),
          gap,
        ],
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/utils/input_validator.dart';
import 'package:grocery_app/src/presentation/auth/auth.dart';
import 'package:grocery_app/src/service/firebase_auth.dart';
import 'package:grocery_app/src/service/shared_pref.dart';
import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../_common/widgets/app_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);

    return AuthBackGroundWrapper(
      title: "Welcome back!",
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            gap,
            AppTextField(
              controller: _emailController,
              hint: "Email",
              icon: const Icon(Icons.email),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                } else if (!InputValidator.isValidEmail(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            gap,
            AppTextField(
              controller: _passwordController,
              hint: "Password",
              obscureText: true,
              icon: const Icon(Icons.lock),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                } else if (!InputValidator.isValidPassword(value)) {
                  return 'Enter a valid password';
                }
                return null;
              },
            ),
            gap,
            TextButton(
              onPressed: () {
                context.push(AppRoute.resetPassword);
              },
              child: const Text("Forgot password?"),
            ),
            gap,
            const SingInOptionView(),
            const SizedBox(height: 32),
            FractionallySizedBox(
              widthFactor: .75,
              child: SizedBox(
                height: 56,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text("Sign In"),
                      ),
              ),
            ),
            gap,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don’t have an account? "),
                InkWell(
                  onTap: () {
                    context.pushReplacement(AppRoute.signUp);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: AppTheme.primary),
                    ),
                  ),
                ),
              ],
            ),
            gap,
          ],
        ),
      ),
    );
  }

  void _login() async {
  final _authService = FirebaseAuthService();
  if (_formKey.currentState!.validate()) {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    final error = await _authService.signIn(email, password);

    setState(() {
      _isLoading = false;
    });

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Sign in failed'),
        ),
      );
    } else {
      final user = FirebaseAuth.instance.currentUser;
      
      if (user != null) {
        final userEmail = user.email;
        final userName = await _fetchUserNameFromFirestore(user.uid);
        if (userEmail != null) {
          await SharedPrefService.setUserEmail(userEmail);
        }
        if (userName != null) {
          await SharedPrefService.setUserName(userName);
        }
        await SharedPrefService.setLoginStatus(true);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed in successfully!')),
        );
        context.pushReplacement(AppRoute.home);
      }
    }
  }
}
Future<String?> _fetchUserNameFromFirestore(String uid) async {
  try {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userDoc.exists) {
      return userDoc.data()?['name'];
    }
  } catch (e) {
    print("Error fetching user name: $e");
  }
  return null;
}
  
}
import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';

class SingInOptionView extends StatelessWidget {
  const SingInOptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Or",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            Icons.facebook,
            Icons.g_mobiledata,
            Icons.inbox,
          ]
              .map(
                (e) => Card(
                  shape: const CircleBorder(),
                  elevation: 4,
                  child: IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF5C5C5C),
                      shadowColor: Colors.green,
                    ),
                    onPressed: () {},
                    icon: Icon(e),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAgcBrr3ZmsQ_MkCeJpuDudVm_U8f5diT4',
    appId: '1:665270910955:web:5e2b5df4f3d7070feb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    authDomain: 'nectar-5294a.firebaseapp.com',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    measurementId: 'G-HQK62DCV9D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXevK09S24HiAHuqsMz-x66Enlg_t31O4',
    appId: '1:665270910955:android:ba9a1df018aec47feb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAj24GfjsjWpT1GrcwyIN0MLYjOd9U-pcA',
    appId: '1:665270910955:ios:8bea429294a76a55eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    iosBundleId: 'com.example.groceryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAj24GfjsjWpT1GrcwyIN0MLYjOd9U-pcA',
    appId: '1:665270910955:ios:8bea429294a76a55eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    iosBundleId: 'com.example.groceryApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAgcBrr3ZmsQ_MkCeJpuDudVm_U8f5diT4',
    appId: '1:665270910955:web:5a63b11252913007eb23ae',
    messagingSenderId: '665270910955',
    projectId: 'nectar-5294a',
    authDomain: 'nectar-5294a.firebaseapp.com',
    storageBucket: 'nectar-5294a.firebasestorage.app',
    measurementId: 'G-1LNFZ1PJ2J',
  );
}
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'src/app/nectar_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const NectarApp(),
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/app_theme.dart';
import 'package:grocery_app/src/app/route_config.dart';

class AlreadyHaveAnAccountView extends StatelessWidget {
  const AlreadyHaveAnAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?"),
        InkWell(
          onTap: () {
            context.pushReplacement(AppRoute.signIn);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 4, right: 8, top: 8, bottom: 8),
            child: Text(
              "Login",
              style: TextStyle(color: AppTheme.primary),
            ),
          ),
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../_common/_common.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const gap = SizedBox(height: 32);

    return BackgroundView.single(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 64,
                right: 0,
                left: 0,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    "assets/images/landing_fruits.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Positioned(
                left: 24,
                right: 24,
                bottom: 64,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Buy ",
                        children: [
                          TextSpan(
                            text: "Grocery",
                            style: textTheme.headlineLarge?.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                          const TextSpan(text: " items easily with us")
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: textTheme.headlineLarge?.copyWith(),
                    ),
                    gap,
                    const Text(
                      "If you keep good food in your fridge, you will eat good food",
                      textAlign: TextAlign.center,
                    ),
                    gap,
                    AppButton.large(
                      onTap: () {
                        context.push(AppRoute.loginOption);
                      },
                      label: "Get Started",
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
lib/src/presentation/auth/widgets/background_auth_wrapper.dart
import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';

class AuthBackGroundWrapper extends StatelessWidget {
  const AuthBackGroundWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    const path = "assets/images/top_banner_fruits.png";

    const gap = SizedBox(height: 24);
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.white),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Image.asset(
            path,
            fit: BoxFit.fitWidth,
          ),
        ),
        Align(alignment: Alignment.topCenter, child: AppBar()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -4),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: AppTheme.background,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24)
                    .copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom),
                child: Column(
                  children: [
                    gap,
                    FractionallySizedBox(
                      widthFactor: .5,
                      child: Container(
                        height: 4,
                        decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    gap,
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
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
import 'package:flutter/material.dart';
import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../../infrastructure/infrastructure.dart';
import '../_common/_common.dart';
import 'widgets/product_description.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.model,
  });

  final ProductModel model;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int itemCount = 1;

  @override
  void initState() {
    super.initState();
    itemCount = widget.model.orderCounter;
  }

  String get totalPrice => (widget.model.price * itemCount).toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BackgroundView.triple(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: context.pop,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppTheme.borderColor,
            ),
          ),
          actions: [
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.shopping_cart_rounded,
                  color: AppTheme.primary,
                ),
              ),
              onTap: () {},
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total:$totalPrice Tk",
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppButton(
                label: "Add to cart",
                onTap: () {
                  ShopProvider.of(context).addToCart(p: widget.model, counter: itemCount);
                  context.pop();
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            clipBehavior: Clip.none,
            slivers: [

