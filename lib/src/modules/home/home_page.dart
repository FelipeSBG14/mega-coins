import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/ui/helpers/debouncer.dart';
import 'widgets/player_row.dart';
import 'package:mobx/mobx.dart';
import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';
import '../../core/ui/helpers/size_extensions.dart';
import '../../core/ui/styles/text_styles.dart';
import 'home_controller.dart';
import 'players/players_modal.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Loader, Messages {
  late final ReactionDisposer statusReactionDisposer;
  final debouncer = Debouncer(milisencods: 200);
  final controller = Modular.get<HomeController>();

  bool isLoading = false;
  String email = '';
  @override
  void initState() {
    controller.getInformation();
    statusReactionDisposer = reaction((_) => controller.homeStatus, (status) {
      switch (status) {
        case HomeStateStatus.inital:
          break;
        case HomeStateStatus.loading:
          showLoader();
          break;
        case HomeStateStatus.success:
          hideLoader();
          final user = controller.currentUser;
          setState(() {
            email = user?.email ?? 'Não encontrado';
            isLoading = true;
          });
          controller.isLoading = true;
          break;
        case HomeStateStatus.error:
          hideLoader();
          showError(controller.errorMessage ?? 'Erro');
          controller.isLoading = true;
          setState(() {
            isLoading = false;
          });
          break;
      }
    });
    super.initState();
  }

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
                    const SizedBox(
                      height: 20,
                    ),
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
                        label: Text('Pesquisar pelo nome'),
                      ),
                      onChanged: (value) {
                        debouncer.call(
                          () {
                            controller.filterByName(value);
                          },
                        );
                      },
                      style: context.textStyles.textRegular
                          .copyWith(color: Colors.white),
                    ),
                    Column(
                      children: [
                        Visibility(
                          visible:
                              controller.currentUser == null ? false : true,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => PlayersModal(
                                    controller: controller,
                                  ),
                                );
                              },
                              child: const Text('Adicionar Jogador'),
                            ),
                          ),
                        ),
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
                        Visibility(
                          visible: isLoading,
                          replacement: const CircularProgressIndicator(),
                          child: SizedBox(
                            height: context.screenHeight * 1,
                            width: screenWidht * 1,
                            child: Observer(
                              builder: (_) {
                                return ListView.builder(
                                  itemCount: controller.playersSearch?.length,
                                  itemBuilder: (context, index) {
                                    final player =
                                        controller.playersSearch?[index];
                                    return controller.playersSearch == null
                                        ? Center(
                                            child: Text(
                                              'Nenhum jogador encontrado !',
                                              style: context
                                                  .textStyles.textRegular
                                                  .copyWith(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                              top: 10,
                                            ),
                                            child: PlayerRow(
                                              controller: controller,
                                              player: player,
                                            ),
                                          );
                                  },
                                );
                              },
                            ),
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
