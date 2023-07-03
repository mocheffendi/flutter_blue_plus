import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import '../controller/main_wrapper_controller.dart';
import 'package:bottom_bar/view/screen_binding.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final MainWrapperController _mainWrapperController =
      Get.find<MainWrapperController>();

  @override
  void initState() {
    super.initState();
    InitialScreenBindings();
    // Get.lazyPut<MainWrapperController>(() => MainWrapperController(),
    // fenix: true);
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> planContainerTrigger = ValueNotifier(0);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          PlanCard(
            notifierValue: planContainerTrigger,
            selectedIndex: 0,
            header: "It's Free",
            subHeader: "For team\nfrom 1 - 5",
          ),
          AppSpaces.horizontalSpace20,
          PlanCard(
              notifierValue: planContainerTrigger,
              selectedIndex: 1,
              header: "Premium",
              subHeader: "\$19/mo")
        ]),
        Container(
            width: 180,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: RadialGradient(
                colors: [
                  ...progressCardGradientList,
                ],
                center: const Alignment(1, 1),
                focal: const Alignment(0.3, -0.1),
                focalRadius: 1.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: DecoratedBox(
                  decoration: BoxDecorationStyles.fadingInnerDecor,
                  child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        const SizedBox(height: 40),
                        Text('Premium',
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24)),
                        AppSpaces.verticalSpace10,
                        Text('for team',
                            style: GoogleFonts.lato(
                                color: HexColor.fromHex("F7A3F9")))
                      ]))),
            )
            // Stack(children: [
            //     Positioned(
            //       top: 5,
            //       left: 5,
            //       child: Container(
            //           width: 50,
            //           height: 50,
            //           decoration: BoxDecoration(
            //               shape: BoxShape.circle,
            //               color: HexColor.fromHex("181a1f")),
            //           child: GreenDoneIcon()),
            //     ),
            //     Center(
            //         child: Column(
            //             crossAxisAlignment:
            //                 CrossAxisAlignment.center,
            //             //mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //           SizedBox(height: 45),
            //           Text("🎉", style: TextStyle(fontSize: 40)),
            //           AppSpaces.verticalSpace20,
            //           Text(header,
            //               style: GoogleFonts.lato(
            //                   color: Colors.black,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 24)),
            //           AppSpaces.verticalSpace10,
            //           Text(subHeader, style: GoogleFonts.lato())
            //         ]))
            //   ])
            ),
        Container(
          width: 300,
          height: 300,
          //BoxDecoration Widget
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                ...progressCardGradientList,
              ],
              center: const Alignment(1, 1),
              focal: const Alignment(0.3, -0.1),
              focalRadius: 1.0,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(
                  5.0,
                  5.0,
                ), //Offset
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],
          ), //BoxDecoration
        ),
        Text(
          "Home",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const Icon(
          IconlyLight.home,
          size: 40,
        ),
      ],
    );
  }
}

class AppColors {
  static List<List<Color>> ballColors = [
    [
      HexColor.fromHex("87D3DF"),
      HexColor.fromHex("DEABEF"),
    ],
    [
      HexColor.fromHex("FC946E"),
      HexColor.fromHex("FFD996"),
    ],
    [
      HexColor.fromHex("87C76F"),
      HexColor.fromHex("87C76F"),
    ],
    [
      HexColor.fromHex("E7B2EF"),
      HexColor.fromHex("EEFCCF"),
    ],
    [
      HexColor.fromHex("8CE0DF"),
      HexColor.fromHex("8CE0DF"),
    ],
    [
      HexColor.fromHex("353645"),
      HexColor.fromHex("1E2027"),
    ],
    [
      HexColor.fromHex("FDA7FF"),
      HexColor.fromHex("FDA7FF"),
    ],
    [
      HexColor.fromHex("899FFE"),
      HexColor.fromHex("899FFE"),
    ],
    [
      HexColor.fromHex("FC946E"),
      HexColor.fromHex("FFD996"),
    ],
    [
      HexColor.fromHex("87C76F"),
      HexColor.fromHex("87C76F"),
    ],
  ];

  static final Color primaryBackgroundColor = HexColor.fromHex("262A34");
  static final Color lightMauveBackgroundColor = HexColor.fromHex("C395FC");
  static final Color primaryAccentColor = HexColor.fromHex("246CFD");
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

// ranges from 0.0 to 1.0

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}

List<Color> progressCardGradientList = [
  //grenn
  HexColor.fromHex("87EFB5"),
  //blue
  HexColor.fromHex("8ABFFC"),
  //pink
  HexColor.fromHex("EEB2E8"),
];

List<Color> cardGradientList = [
  //grenn
  const Color.fromARGB(255, 227, 0, 248),
  //blue
  const Color.fromARGB(255, 252, 39, 127),
  //pink
  const Color.fromARGB(255, 212, 58, 11),
];

class BoxDecorationStyles {
  static final BoxDecoration fadingGlory = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          HexColor.fromHex("625B8B"),
          const Color.fromRGBO(98, 99, 102, 1),
          HexColor.fromHex("#181a1f"),
          HexColor.fromHex("#181a1f")
        ]),
    borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    //border: Border.all(color: Colors.red, width: 5)
  );

  static final BoxDecoration fadingInnerDecor = BoxDecoration(
      color: HexColor.fromHex("181A1F"),
      borderRadius: BorderRadius.circular(20));
}

class AppSpaces {
  static const verticalSpace40 = SizedBox(height: 40);
  static const verticalSpace20 = SizedBox(height: 20);
  static const verticalSpace10 = SizedBox(height: 10);
  static const horizontalSpace20 = SizedBox(width: 20);
  static const horizontalSpace10 = SizedBox(width: 10);
}

class DarkRadialBackground extends StatelessWidget {
  final String position;
  final Color color;
  var list = List.generate(
    3,
    (index) => HexColor.fromHex("1D192D"),
  );
  DarkRadialBackground(
      {super.key, required this.color, required this.position});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: [...list, this.color],
        center: (position == "bottomRight")
            ? const Alignment(1.0, 1.0)
            : const Alignment(-1.0, -1.0),
      ),
    )));
  }
}

class PlanCard extends StatefulWidget {
  final int selectedIndex;
  final ValueNotifier<int> notifierValue;

  final String header;
  final String subHeader;
  const PlanCard(
      {Key? key,
      required this.selectedIndex,
      required this.notifierValue,
      required this.header,
      required this.subHeader})
      : super(key: key);

  @override
  State<PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> {
  final MainWrapperController _mainWrapperController =
      Get.find<MainWrapperController>();

  @override
  void initState() {
    super.initState();
    InitialScreenBindings();
    // Get.lazyPut<MainWrapperController>(() => MainWrapperController(),
    // fenix: true);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
          onTap: () {
            widget.notifierValue.value = widget.selectedIndex;
            print(widget.notifierValue.value);
            Timer(const Duration(milliseconds: 500), () {
              _mainWrapperController.goToTab(widget.notifierValue.value);
            });
          },
          child: ValueListenableBuilder(
              valueListenable: widget.notifierValue,
              builder: (BuildContext context, _, __) {
                return Container(
                    width: 180,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: RadialGradient(
                        colors: [
                          ...cardGradientList,
                        ],
                        center: const Alignment(1, 1),
                        focal: const Alignment(0.3, -0.1),
                        focalRadius: 1.0,
                      ),
                    ),
                    child: widget.notifierValue.value != widget.selectedIndex
                        ? Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: DecoratedBox(
                                decoration:
                                    BoxDecorationStyles.fadingInnerDecor,
                                child: Center(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                      const SizedBox(height: 40),
                                      Text(widget.header,
                                          style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24)),
                                      AppSpaces.verticalSpace10,
                                      Text(widget.subHeader,
                                          style: GoogleFonts.lato(
                                              color:
                                                  HexColor.fromHex("F7A3F9")))
                                    ]))),
                          )
                        : Stack(children: [
                            Positioned(
                              top: 5,
                              left: 5,
                              child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: HexColor.fromHex("181a1f")),
                                  child: const GreenDoneIcon()),
                            ),
                            Center(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  const SizedBox(height: 45),
                                  const Text("🎉",
                                      style: TextStyle(fontSize: 40)),
                                  AppSpaces.verticalSpace20,
                                  Text(widget.header,
                                      style: GoogleFonts.lato(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24)),
                                  AppSpaces.verticalSpace10,
                                  Text(widget.subHeader,
                                      style: GoogleFonts.lato())
                                ]))
                          ]));
              })),
    );
  }
}

class GreenDoneIcon extends StatelessWidget {
  const GreenDoneIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: HexColor.fromHex("78B462")),
          child: const Icon(Icons.done, color: Colors.white)),
    );
  }
}
