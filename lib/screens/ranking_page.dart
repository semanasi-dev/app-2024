import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sasiqrcode/screens/loading_page.dart';
import 'package:sasiqrcode/store/ranking_store.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  RankingStore store = RankingStore();

  @override
  void initState() {
    super.initState();
    store.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          double padding = isMobile ? 20 : 40;
          double iconSize = isMobile ? 50 : 100;
          double titleFontSize = isMobile ? 20 : 40;
          double itemFontSize = isMobile ? 16 : 24;
          double listPadding = isMobile ? padding : constraints.maxWidth * 0.2;

          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  './lib/assets/background.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight,
                      child: SafeArea(
                        child: ScopedBuilder<RankingStore, RankingState>(
                          store: store,
                          onLoading: (context) => const LoadingPage(),
                          onState: (context, state) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(
                                listPadding,
                                constraints.maxHeight * 0.15,
                                listPadding,
                                0,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.emoji_events_outlined,
                                        size: iconSize,
                                        color: Colors.white,
                                      ),
                                      SelectableText(
                                        'Ranking de jogadores',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.robotoMono(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: titleFontSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight * 0.04,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: state.topUsers.length > 10
                                          ? 10
                                          : state.topUsers.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 25),
                                          child: Wrap(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                ),
                                                height: isMobile ? 50 : 70,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                      offset:
                                                          const Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        index <= 2
                                                            ? medalIcon(index,
                                                                itemFontSize)
                                                            : FittedBox(
                                                                child:
                                                                    SelectableText(
                                                                  '${index + 1}.',
                                                                  style: GoogleFonts
                                                                      .robotoMono(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    fontSize:
                                                                        itemFontSize,
                                                                  ),
                                                                ),
                                                              ),
                                                        FittedBox(
                                                          child: SelectableText(
                                                            '${state.topUsers[index]['nome']}',
                                                            style: GoogleFonts
                                                                .robotoMono(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontSize:
                                                                  itemFontSize,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    FittedBox(
                                                      child: SelectableText(
                                                        '${state.topUsers[index]['pontos']}',
                                                        style: GoogleFonts
                                                            .robotoMono(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize:
                                                              itemFontSize,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (index == 2)
                                                const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 25),
                                                  child: Divider(
                                                    color: Colors.white,
                                                    thickness: 3,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: padding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        store.init();
                      },
                      icon: const Icon(
                        Icons.update,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget medalIcon(int index, double size) {
    switch (index) {
      case 0:
        return Icon(
          Icons.workspace_premium_sharp,
          color: const Color(0xffffD700),
          size: size * 1.7,
        );
      case 1:
        return Icon(
          Icons.workspace_premium_sharp,
          color: Colors.grey,
          size: size * 1.7,
        );
      case 2:
        return Icon(
          Icons.workspace_premium_sharp,
          color: Colors.brown,
          size: size * 1.7,
        );
      default:
        return const SizedBox();
    }
  }
}
