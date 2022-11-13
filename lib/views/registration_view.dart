import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nappy_mobile/utilities/app_theme.dart';
import 'package:nappy_mobile/views/home/home_view.dart';
import 'package:nappy_mobile/views/login_view.dart';
import 'package:nappy_mobile/widgets/label.dart';
import 'package:nappy_mobile/utilities/constants.dart';
import 'package:nappy_mobile/utilities/password_text_field.dart';
import 'package:nappy_mobile/utils.dart';

import '../controllers/auth_controller.dart';

class RegistrationView extends ConsumerStatefulWidget {
  static const String id = "/registration";
  const RegistrationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends ConsumerState<RegistrationView> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  static final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  void register() async {
    final navigator = Navigator.of(context);
    bool success = await ref.read(authControllerProvider.notifier).registerWithEmail(
          context: context,
          email: _email.text,
          password: _password.text,
        );
    if (success) {
      navigator.pushNamed(HomeView.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kMobileDefaultPadding,
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vSpace(20),
                    const Center(
                      child: Text(
                        'Register',
                        style: AppTheme.headline1,
                      ),
                    ),
                    vSpace(8),
                    const Center(
                      child: Text(
                        'Create your new account',
                        style: AppTheme.textMuted,
                      ),
                    ),
                    vSpace(20),
                    const Label("Email"),
                    TextFormField(
                      controller: _email,
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const Label("Password"),
                    PasswordTextField(
                      controller: _password,
                      action: TextInputAction.next,
                    ),
                    const Label("Confirm Password"),
                    PasswordTextField(
                      action: TextInputAction.done,
                      onEditingComplete: () => register(),
                    ),
                    vSpace(20),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(wordSpacing: 3.0),
                        children: [
                          TextSpan(
                            text: "By signing you agree to our ",
                            style: AppTheme.paragraph,
                          ),
                          TextSpan(text: "Terms of Use ", style: AppTheme.textMuted),
                          TextSpan(text: "and ", style: AppTheme.paragraph),
                          TextSpan(text: "Privacy Policy ", style: AppTheme.textMuted),
                        ],
                      ),
                    ),
                    vSpace(20),
                    Consumer(
                      builder: (context, ref, child) {
                        final bool isLoading = ref.watch(authControllerProvider);
                        return ElevatedButton(
                          onPressed: () => register(),
                          child: isLoading
                              ? const SpinKitThreeBounce(
                                  color: Colors.white,
                                  size: 24,
                                )
                              : const Text(
                                  "Register",
                                  style: AppTheme.kLabelStyle,
                                ),
                        );
                      },
                    ),
                    vSpace(20),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Already have an account? ",
                                style: AppTheme.paragraphBlack,
                              ),
                              TextSpan(
                                text: "Login",
                                style: AppTheme.paragraph,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacementNamed(context, LoginView.id);
                                  },
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
