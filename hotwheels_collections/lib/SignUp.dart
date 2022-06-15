import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:hotwheels_collections/provider/GoogleSignIn.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              HexColor('#FFAA00'),
              HexColor('#9F2C00'),
            ],
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(50, 30, 50, 0),
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            const AssetImage('assets/images/hwcorrection.png'),
                        fit: BoxFit.scaleDown),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
                child: InkWell(
                  onTap: () {
                    final provider =
                        Provider.of<GoogleSignProvider>(context, listen: false);
                    provider.googleLogin();
                  },
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(45)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/GoogleLogo.svg',
                          height: 30,
                          width: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Sign in with Google",
                          style: TextStyle(
                              fontSize: 25, color: HexColor('#707070')),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
    // return Scaffold(
    //   backgroundColor: const Color.fromARGB(255, 255, 136, 0),
    //   body: Container(
    //     decoration: BoxDecoration(
    //         gradient: LinearGradient(
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //       colors: [
    //         HexColor('#FFAA00'),
    //         HexColor('#9F2C00'),
    //       ],
    //     )),
    //     child: Stack(
    //       children: <Widget>[

    //         Pinned.fromPins(
    //           Pin(start: 46.0, end: 46.0),
    //           Pin(size: 83.0, start: 77.0),
    //           child: Container(
    //             decoration: BoxDecoration(
    //               image: DecorationImage(
    //                 image: const AssetImage('assets/images/hwcorrection.png'),
    //                 fit: BoxFit.contain,
    //               ),
    //             ),
    //           ),
    //         ),
    //         Pinned.fromPins(
    //           Pin(start: 34.0, end: 34.0),
    //           Pin(size: 59.0, middle: 0.4038),
    //           child: InkWell(
    //             onTap: () {
    //               final provider =
    //                   Provider.of<GoogleSignProvider>(context, listen: false);
    //               provider.googleLogin();
    //             },
    //             child: Stack(
    //               children: <Widget>[
    //                 Container(
    //                   decoration: BoxDecoration(
    //                     color: const Color(0xffffffff),
    //                     borderRadius: BorderRadius.circular(51.0),
    //                   ),
    //                 ),
    //                 Pinned.fromPins(
    //                   Pin(start: 24.6, end: 25.3),
    //                   Pin(size: 35.6, middle: 0.4927),
    //                   child: Pinned.fromPins(
    //                     Pin(size: 235, middle: 0.5),
    //                     Pin(size: 35.6, middle: 0.4927),
    //                     child: Stack(
    //                       children: <Widget>[
    //                         Pinned.fromPins(
    //                           Pin(size: 204.0, end: 0.0),
    //                           Pin(size: 27.0, start: 2.9),
    //                           child: Text(
    //                             'Sign in with Google',
    //                             style: TextStyle(
    //                               fontFamily: 'Segoe UI',
    //                               fontSize: 20,
    //                               color: const Color(0xff707070),
    //                             ),
    //                             textAlign: TextAlign.center,
    //                           ),
    //                         ),
    //                         Pinned.fromPins(
    //                           Pin(size: 35.6, start: 0.0),
    //                           Pin(start: 0.0, end: 0.0),
    //                           child: Stack(
    //                             children: <Widget>[
    //                               SizedBox.expand(
    //                                   child: SvgPicture.string(
    //                                 _svg_qtizgh,
    //                                 allowDrawingOutsideViewBox: true,
    //                                 fit: BoxFit.fill,
    //                               )),
    //                               Pinned.fromPins(
    //                                 Pin(size: 27.9, start: 2.1),
    //                                 Pin(size: 13.8, start: 0.0),
    //                                 child: SvgPicture.string(
    //                                   _svg_l7fkbi,
    //                                   allowDrawingOutsideViewBox: true,
    //                                   fit: BoxFit.fill,
    //                                 ),
    //                               ),
    //                               Pinned.fromPins(
    //                                 Pin(size: 27.8, start: 2.0),
    //                                 Pin(size: 14.2, end: 0.0),
    //                                 child: SvgPicture.string(
    //                                   _svg_ybcw8v,
    //                                   allowDrawingOutsideViewBox: true,
    //                                   fit: BoxFit.fill,
    //                                 ),
    //                               ),
    //                               Pinned.fromPins(
    //                                 Pin(size: 17.8, end: 0.0),
    //                                 Pin(size: 16.8, end: 4.6),
    //                                 child: SvgPicture.string(
    //                                   _svg_e9c9o,
    //                                   allowDrawingOutsideViewBox: true,
    //                                   fit: BoxFit.fill,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

// const String _svg_qtizgh =
//     '<svg viewBox="0.0 0.0 35.6 35.6" ><path transform="translate(-4.0, -4.0)" d="M 39.24910354614258 18.31196975708008 L 37.81550598144531 18.31196975708008 L 37.81550598144531 18.23810958862305 L 21.79763603210449 18.23810958862305 L 21.79763603210449 25.35716247558594 L 31.85596656799316 25.35716247558594 C 30.38855743408203 29.50134468078613 26.44549179077148 32.47621154785156 21.79763603210449 32.47621154785156 C 15.90038871765137 32.47621154785156 11.11905288696289 27.69488143920898 11.11905288696289 21.79763603210449 C 11.11905288696289 15.90038871765137 15.90038871765137 11.11905288696289 21.79763603210449 11.11905288696289 C 24.51978492736816 11.11905288696289 26.99632453918457 12.14597702026367 28.88198471069336 13.82340335845947 L 33.91604614257812 8.789342880249023 C 30.73738861083984 5.826927185058594 26.48553276062012 4 21.79763603210449 4 C 11.96889019012451 4 4 11.96889019012451 4 21.79763603210449 C 4 31.62637519836426 11.96889019012451 39.59526443481445 21.79763603210449 39.59526443481445 C 31.62637519836426 39.59526443481445 39.59526443481445 31.62637519836426 39.59526443481445 21.79763603210449 C 39.59526443481445 20.60430526733398 39.47246551513672 19.43944931030273 39.24910354614258 18.31196975708008 Z" fill="#fbc02d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_l7fkbi =
//     '<svg viewBox="2.1 0.0 27.9 13.8" ><path transform="translate(-4.25, -4.0)" d="M 6.306000232696533 13.51372528076172 L 12.15341472625732 17.80206680297852 C 13.73562431335449 13.88480567932129 17.56745338439941 11.11905288696289 22.05156707763672 11.11905288696289 C 24.77371597290039 11.11905288696289 27.25025367736816 12.14597702026367 29.13591575622559 13.82340335845947 L 34.16997528076172 8.789342880249023 C 30.9913215637207 5.826927185058594 26.73946380615234 4 22.05156707763672 4 C 15.21549606323242 4 9.287105560302734 7.85941743850708 6.306000232696533 13.51372528076172 Z" fill="#e53935" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_ybcw8v =
//     '<svg viewBox="2.0 21.4 27.8 14.2" ><path transform="translate(-4.24, -6.65)" d="M 22.03934478759766 42.24406051635742 C 26.63647651672363 42.24406051635742 30.81357765197754 40.48476028442383 33.97177124023438 37.6237907409668 L 28.46340179443359 32.96258926391602 C 26.6765193939209 34.31610107421875 24.45537567138672 35.12500762939453 22.03934478759766 35.12500762939453 C 17.41017913818359 35.12500762939453 13.47957229614258 32.17326354980469 11.99880981445312 28.05400466918945 L 6.194999694824219 32.52566146850586 C 9.140509605407715 38.28942489624023 15.12229347229004 42.24406051635742 22.03934478759766 42.24406051635742 Z" fill="#4caf50" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_e9c9o =
//     '<svg viewBox="17.8 14.2 17.8 16.8" ><path transform="translate(-6.2, -5.76)" d="M 41.45147323608398 20.07386016845703 L 41.43723297119141 20 L 40.01787185668945 20 L 24 20 L 24 27.11905670166016 L 34.05833435058594 27.11905670166016 C 33.35354995727539 29.10972023010254 32.07301330566406 30.82630157470703 30.42138862609863 32.07658386230469 C 30.42227745056152 32.0756950378418 30.42317008972168 32.0756950378418 30.42405700683594 32.07480621337891 L 35.93243026733398 36.73600769042969 C 35.54265594482422 37.09018325805664 41.79763793945312 32.45834732055664 41.79763793945312 23.55952835083008 C 41.79763793945312 22.36619567871094 41.67483520507812 21.20133972167969 41.45147323608398 20.07386016845703 Z" fill="#1565c0" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';


