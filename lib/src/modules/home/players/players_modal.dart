import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import '../../../core/ui/helpers/size_extensions.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../models/players_model.dart';
import '../home_controller.dart';

class PlayersModal extends StatefulWidget {
  final HomeController controller;
  final PlayersModel? player;
  const PlayersModal({
    Key? key,
    this.player,
    required this.controller,
  }) : super(key: key);

  @override
  State<PlayersModal> createState() => _PlayersModalState();
}

class _PlayersModalState extends State<PlayersModal> {
  final nameEC = TextEditingController();
  final coinsEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void _closeModal() {
    Navigator.pop(context);
  }

  void _formSubmit(id, name, coins) {
    widget.controller.addPlayers(
      id,
      name,
      coins,
    );
  }

  @override
  void initState() {
    if (widget.player != null) {
      nameEC.text = widget.player!.name;
      coinsEC.text = widget.player!.coins.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    nameEC.dispose();
    coinsEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidht;
    return Material(
      color: Colors.black26,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 33, 7, 38),
        elevation: 10,
        child: Container(
          width: screenWidth * (screenWidth > 1200 ? .5 : .7),
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${widget.player?.id == null ? 'Adicionar' : 'Editar'} um Jogador',
                        style: context.textStyles.textRegular
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: _closeModal,
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameEC,
                          onFieldSubmitted: (_) => _formSubmit(
                            widget.player?.id,
                            nameEC.text,
                            int.parse(coinsEC.text),
                          ),
                          decoration: InputDecoration(
                            label: Text(
                              'Nome do Jogador',
                              style: context.textStyles.textRegular.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          style: context.textStyles.textRegular
                              .copyWith(color: Colors.white),
                          keyboardType: TextInputType.name,
                          validator: Validatorless.required(
                            'Coloque um nome para o jogador',
                          ),
                        ),
                        TextFormField(
                          controller: coinsEC,
                          onFieldSubmitted: (_) => _formSubmit(
                            widget.player?.id,
                            nameEC.text,
                            int.parse(coinsEC.text),
                          ),
                          decoration: InputDecoration(
                            label: Text(
                              'Coins do Jogador',
                              style: context.textStyles.textRegular.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            suffixIcon: Image.asset(
                              'assets/images/mega-coin.gif',
                              scale: 4,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          style: context.textStyles.textRegular
                              .copyWith(color: Colors.white),
                          keyboardType: TextInputType.number,
                          validator: Validatorless.multiple([
                            Validatorless.required(
                              'Informe uma quantidade de coins',
                            ),
                            Validatorless.number(
                              'É necessário informar um número',
                            ),
                          ]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final isValid =
                                formKey.currentState?.validate() ?? false;
                            if (isValid) {
                              _formSubmit(
                                widget.player?.id,
                                nameEC.text,
                                int.parse(coinsEC.text),
                              );
                            } else {
                              return;
                            }
                          },
                          child: Text(
                            'Enviar',
                            style: context.textStyles.textRegular.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
