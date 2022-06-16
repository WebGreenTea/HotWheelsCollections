import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hotwheels_collections/Page/MainLine.dart';
import 'package:provider/provider.dart';
import '../provider/GoogleSignIn.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginedPage extends StatelessWidget {
  const LoginedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final provider =
              Provider.of<GoogleSignProvider>(context, listen: false);
          provider.logout();
        },
        child: Icon(Icons.logout,color: HexColor('#ffffff'),),
        backgroundColor: Colors.grey[700],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
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
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Padding(
            padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
            child: Container(
              height: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: const AssetImage('assets/images/hwcorrection.png'),
                    fit: BoxFit.scaleDown),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: HexColor('#DB3D00')),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'My Collections',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    image: DecorationImage(
                        image:
                            const AssetImage('assets/images/collections.png'),
                        fit: BoxFit.cover),
                  ),
                ),
              )
            ],
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(30, 40, 30, 40),
              child: SvgPicture.string(
                whiteLine,
                allowDrawingOutsideViewBox: true,
                fit: BoxFit.fill,
              )),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) { 
                  return Mainline();
               }));
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: HexColor('##006EA7')),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'MainLine (1995-2022)',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Container(
                    height: 190,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      image: DecorationImage(
                          image: const AssetImage('assets/images/mainline.jpg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          )
        ]),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Logined"),
    //     actions: [
    //       TextButton(
    //           onPressed: () {
    //             final provider = Provider.of<GoogleSignProvider>(context,listen: false);
    //             provider.logout();
    //           },
    //           style: TextButton.styleFrom(
    //             primary: Colors.pink,
    //           ),
    //           child: Text("logout"))
    //     ],
    //   ),

    // );
  }
}

const String whiteLine =
    '<svg viewBox="29.5 326.5 316.0 1.0" ><path transform="translate(29.5, 326.5)" d="M 0 0 L 316 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
