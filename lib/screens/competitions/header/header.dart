import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futawesome/core/contants/app_colors.dart';
import 'package:futawesome/core/models/competition.dart';

class Header extends StatelessWidget {
  const Header({Key? key, required this.competition}) : super(key: key);

  final Competition competition;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: const Color(primaryHex),
            padding:
                const EdgeInsets.only(right: 36, left: 36, top: 10, bottom: 10),
            child: Row(
              children: [
                Image.network(competition.logo, width: 60),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    competition.nome,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Row(
                          children: [
                            const Text(
                              "Temporada: ",
                              style: TextStyle(
                                color: AppColors.textSecondaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(competition.edicaoAtual.temporada,
                                style: const TextStyle(
                                    color: AppColors.textSecondaryColor,
                                    fontSize: 18)),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            const Text(
                              "Status: ",
                              style: TextStyle(
                                color: AppColors.textSecondaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(competition.status,
                                style: const TextStyle(
                                    color: AppColors.textSecondaryColor,
                                    fontSize: 18)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 20, top: 20),
                        child: Row(
                          children: [
                            const Text(
                              "Tipo: ",
                              style: TextStyle(
                                color: AppColors.textSecondaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(competition.tipo,
                                style: const TextStyle(
                                    color: AppColors.textSecondaryColor,
                                    fontSize: 18)),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 20),
                        child: Row(
                          children: [
                            Text(
                              competition.rodadaAtual == null
                                  ? "Fase: "
                                  : "Rodada: ",
                              style: const TextStyle(
                                color: AppColors.textSecondaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                                competition.rodadaAtual != null
                                    ? "${competition.rodadaAtual!.rodada}º"
                                    : competition.faseAtual!.nome,
                                style: const TextStyle(
                                    color: AppColors.textSecondaryColor,
                                    fontSize: 18)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                      color: AppColors.textSecondaryColor, height: 60),
                  const Text("Fique por dentro das novidades!",
                      style: TextStyle(
                          color: AppColors.textSecondaryColor, fontSize: 16)),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                          onPressed: () {},
                          elevation: 5,
                          color: AppColors.textSecondaryColor.withOpacity(0.85),
                          child: Image.network(
                            "https://fastly.4sqi.net/img/general/600x600/85749956_BFJnSJSPGLq5Iq7CrqD70hro5A8mLa5hGb2wVxJWOVw.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {},
                          elevation: 5,
                          color: AppColors.textSecondaryColor.withOpacity(0.85),
                          child: Image.network(
                            "https://logodownload.org/wp-content/uploads/2015/05/espn-logo-4.png",
                            width: 40,
                            height: 30,
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {},
                          elevation: 5,
                          color: AppColors.textSecondaryColor.withOpacity(0.85),
                          child: Image.network(
                            "https://upload.wikimedia.org/wikipedia/pt/archive/9/9e/20211202144042%21Logotipo_da_TV_Globo.png",
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                      color: AppColors.textSecondaryColor, height: 60),
                  const Text("Estatísticas",
                      style: TextStyle(
                          color: AppColors.textSecondaryColor, fontSize: 18)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CupertinoButton(
                        child: const Text("Tabela"),
                        onPressed: () {},
                      ),
                      CupertinoButton(
                        child: const Text("Artilharia"),
                        onPressed: () {},
                      ),
                      CupertinoButton(
                        child: const Text("Rodadas e resultados"),
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
