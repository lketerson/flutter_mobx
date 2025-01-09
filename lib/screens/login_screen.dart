import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../widgets/custom_icon_button.dart';
import '../widgets/custom_text_field.dart';
import 'list_screen.dart';
import 'stores/login_store.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginStore = LoginStore();

  late ReactionDisposer disposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    disposer = reaction((_) => loginStore.loginPressed, (loggedIn) {
      if (loginStore.loggedIn) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const ListScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 16,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CustomTextField(
                      hint: 'E-mail',
                      prefix: const Icon(Icons.account_circle),
                      textInputType: TextInputType.emailAddress,
                      onChanged: loginStore.setEmail,
                      enabled: true,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Observer(builder: (_) {
                      return CustomTextField(
                        hint: 'Senha',
                        prefix: const Icon(Icons.lock),
                        obscure: loginStore.isPasswordObscured,
                        onChanged: loginStore.setPassword,
                        enabled: true,
                        suffix: CustomIconButton(
                          radius: 32,
                          iconData: loginStore.isPasswordObscured
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onTap: loginStore.tooglePasswordVisibility,
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    Observer(
                      builder: (_) {
                        return SizedBox(
                          height: 44,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              disabledBackgroundColor:
                                  Theme.of(context).primaryColor.withAlpha(100),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            onPressed: loginStore.loginPressed as VoidCallback?,
                            child: loginStore.isLoading
                                ? const CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }
}
