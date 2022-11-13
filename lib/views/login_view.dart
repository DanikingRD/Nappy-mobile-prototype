import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nappy_mobile/controllers/auth_controller.dart';
import 'package:nappy_mobile/utilities/app_theme.dart';
import 'package:nappy_mobile/views/home/home_view.dart';
import 'package:nappy_mobile/views/registration_view.dart';
import 'package:nappy_mobile/widgets/label.dart';
import 'package:nappy_mobile/utilities/password_text_field.dart';
import 'package:nappy_mobile/utils.dart';

class LoginView extends ConsumerStatefulWidget {
  static const String id = "/login";

  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  static final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  void tryLogin() async {
    if (_formKey.currentState!.validate()) {
      final navigator = Navigator.of(context);
      bool loggedIn = await ref.read(authControllerProvider.notifier).logIn(
            context: context,
            email: _email.text,
            password: _password.text,
          );
      if (loggedIn) {
        navigator.pushReplacementNamed(HomeView.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconTheme = Theme.of(context).iconTheme;
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: LayoutBuilder(builder: (context, constraints) {
              return SizedBox(
                width: 320,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Welcome Back',
                          style: AppTheme.headline1,
                        ),
                      ),
                      vSpace(8),
                      const Center(
                        child: Text(
                          'Login to your account',
                          style: AppTheme.textMuted,
                        ),
                      ),
                      vSpace(20),
                      const Label(
                        'Email',
                      ),
                      TextFormField(
                        autofocus: true,
                        controller: _email,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: iconTheme.color,
                          ),
                        ),
                        validator: (String? val) {
                          if (!EmailValidator.validate(val!)) {
                            return "Uh oh - this email address looks wrong.";
                          } else {
                            return null;
                          }
                        },
                      ),
                      vSpace(20),
                      const Label(
                        'Password',
                      ),
                      PasswordTextField(
                        controller: _password,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: iconTheme.color,
                        ),
                        onEditingComplete: () => tryLogin(),
                      ),
                      vSpace(8),
                      Row(
                        children: const [
                          Spacer(),
                          Text(
                            'Forgot password?',
                            style: AppTheme.textMuted,
                          ),
                        ],
                      ),
                      vSpace(4),
                      const Divider(
                        thickness: 2,
                      ),
                      ElevatedButton(
                        onPressed: () => tryLogin(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: isLoading
                              ? const SpinKitThreeBounce(
                                  color: Colors.white,
                                  size: 24,
                                )
                              : const Text(
                                  'Log in',
                                  style: AppTheme.kLabelStyle,
                                ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  style: AppTheme.paragraphBlack,
                                  text: 'Not a member yet? ',
                                ),
                                TextSpan(
                                  style: AppTheme.paragraph,
                                  text: 'Sign Up',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacementNamed(context, RegistrationView.id);
                                    },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
