import 'package:flutter/material.dart';
import 'package:mega_coins/src/modules/home/widgets/player_row.dart';

import '../../core/ui/helpers/size_extensions.dart';
import '../../core/ui/styles/text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenShortestSize = context.screenShortestSide;
    final screenWidht = context.screenWidht;
    return Scaffold(
      body: Stack(
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
                    Container(
                      width: screenWidht * 1,
                      height: context.screenHeight * 0.20,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/leaderboard.png',
                          ),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Pesquisar pro nome'),
                      ),
                      style: context.textStyles.textRegular
                          .copyWith(color: Colors.white),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: screenShortestSize * 0.25,
                              height: context.screenHeight * 0.10,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/player.png',
                                  ),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            Container(
                              width: screenShortestSize * 0.25,
                              height: context.screenHeight * 0.05,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/megacoins.png',
                                  ),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: context.screenHeight * 1,
                          width: screenWidht * 1,
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return const PlayerRow();
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
