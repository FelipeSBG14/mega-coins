import 'package:flutter/material.dart';

import '../../../core/ui/helpers/size_extensions.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../models/players_model.dart';
import '../home_controller.dart';

class PlayersDeleteModal extends StatefulWidget {
  final HomeController controller;
  final PlayersModel? player;
  const PlayersDeleteModal({
    Key? key,
    this.player,
    required this.controller,
  }) : super(key: key);

  @override
  State<PlayersDeleteModal> createState() => _PlayersDeleteModalState();
}

class _PlayersDeleteModalState extends State<PlayersDeleteModal> {
  void _closeModal() {
    Navigator.pop(context);
  }

  void _submit(id) async {
    await widget.controller.playerDelete(
      id,
    );
    _closeModal();
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
                        'Tem certeza que deseja deletar ${widget.player?.name} ?',
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ao deletar, você perderá os dados do jogador !',
                        style: context.textStyles.textRegular.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => _submit(widget.player?.id),
                            child: Text(
                              'Deletar',
                              style: context.textStyles.textRegular.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: () => _closeModal(),
                            child: Text(
                              'Cancelar',
                              style: context.textStyles.textRegular.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
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
