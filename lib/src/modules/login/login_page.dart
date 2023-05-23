import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';
import '../../core/ui/helpers/size_extensions.dart';
import '../../core/ui/styles/text_styles.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Loader, Messages {
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late final ReactionDisposer statusReactionDisposer;
  final controller = Modular.get<LoginController>();
  @override
  void initState() {
    statusReactionDisposer = reaction((_) => controller.loginStatus, (status) {
      switch (status) {
        case LoginStateStatus.inital:
          break;
        case LoginStateStatus.loading:
          showLoader();
          break;
        case LoginStateStatus.success:
          hideLoader();
          Modular.to.navigate('/home');
          break;
        case LoginStateStatus.error:
          hideLoader();
          showError(controller.errorMessage ?? 'Erro');
          break;
      }
    });
    super.initState();
  }

  void _formSubmit() {
    final formValid = formKey.currentState?.validate() ?? false;
    if (formValid) {
      controller.login(emailEC.text, passwordEC.text);
    } else {
      return;
    }
  }

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    statusReactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidht = context.screenWidht;
    var screenHeight = context.screenHeight;
    return Scaffold(
      body: Form(
        key: formKey,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/fundo.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: context.percentWidht(screenWidht < 1300 ? .7 : .3),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidht * 1,
                        height: context.screenHeight * 0.20,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/logomega.png',
                            ),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'LOGIN',
                        style: context.textStyles.textRegular.copyWith(
                          color: Colors.white,
                          fontSize: 60,
                        ),
                      ),
                      TextFormField(
                        controller: emailEC,
                        onFieldSubmitted: (_) => _formSubmit(),
                        decoration: const InputDecoration(
                          label: Text('E-mail'),
                        ),
                        style: context.textStyles.textRegular
                            .copyWith(color: Colors.white),
                        validator: Validatorless.multiple([
                          Validatorless.required('E-mail obrigatório'),
                          Validatorless.email('E-mail inválido'),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Observer(
                        builder: (_) {
                          return TextFormField(
                            controller: passwordEC,
                            onFieldSubmitted: (_) => _formSubmit(),
                            obscureText: !controller.showPassword,
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    controller.showOrHidePassword(),
                                icon: Icon(
                                  controller.showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                            validator:
                                Validatorless.required('Digite sua senha'),
                            style: context.textStyles.textRegular
                                .copyWith(color: Colors.white),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: screenHeight * 0.08,
                        width: screenWidht * 0.3,
                        child: ElevatedButton(
                          onPressed: () => _formSubmit(),
                          child: Text(
                            'Entrar',
                            style: context.textStyles.textRegular.copyWith(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
