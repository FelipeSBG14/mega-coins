import 'package:flutter/material.dart';

import '../../../core/ui/styles/text_styles.dart';
import '../../../models/players_model.dart';
import '../home_controller.dart';
import '../players/players_delete_modal.dart';
import '../players/players_modal.dart';

class PlayerRow extends StatelessWidget {
  final HomeController controller;
  final PlayersModel? player;
  const PlayerRow({
    Key? key,
    required this.controller,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          player!.name,
          style: context.textStyles.textRegular
              .copyWith(color: Colors.white, fontSize: 30),
          overflow: TextOverflow.clip,
        ),
        Row(
          children: [
            Text(
              player!.coins.toString(),
              style: context.textStyles.textRegular
                  .copyWith(color: Colors.white, fontSize: 30),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              'assets/images/mega-coin.gif',
            ),
            Visibility(
              visible: controller.currentUser == null ? false : true,
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => PlayersModal(
                      player: player,
                      controller: controller,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
            ),
            Visibility(
              visible: controller.currentUser == null ? false : true,
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => PlayersDeleteModal(
                      player: player,
                      controller: controller,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
