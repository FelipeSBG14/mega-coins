import 'package:flutter/material.dart';

import '../../../core/ui/styles/text_styles.dart';

class PlayerRow extends StatelessWidget {
  const PlayerRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Felipe Sanches',
          style: context.textStyles.textRegular
              .copyWith(color: Colors.white, fontSize: 30),
          overflow: TextOverflow.clip,
        ),
        Row(
          children: [
            Text(
              '5',
              style: context.textStyles.textRegular
                  .copyWith(color: Colors.white, fontSize: 30),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              'assets/images/mega-coin.gif',
            )
          ],
        )
      ],
    );
  }
}
