import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hotwheels_collections/modelData/mainlineData.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MainlineCar extends StatefulWidget {
  final MainLineData CarData;
  const MainlineCar({Key? key, required this.CarData}) : super(key: key);

  @override
  State<MainlineCar> createState() => _MainlineCarState();
}

class _MainlineCarState extends State<MainlineCar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.CarData.ModelName),
        // ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            HexColor('#FFFFFF'),
            HexColor('#707070'),
          ],
        )),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Center(
                      child: Text(
                    widget.CarData.ModelName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    children: [
                      Text(
                        'Year : ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        widget.CarData.YEAR.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
                  child: Row(
                    children: [
                      Text(
                        'Number in year : ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        widget.CarData.NumbersInYear.length == 0
                            ? '---'
                            : widget.CarData.NumbersInYear,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    children: [
                      Text(
                        'Series : ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        widget.CarData.Series,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
                  child: Row(
                    children: [
                      Text(
                        'Number in Series : ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        widget.CarData.SeriesNumber.length == 0
                            ? '---'
                            : widget.CarData.SeriesNumber,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    children: [
                      Text(
                        'ToyCode : ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        widget.CarData.ToyID.length == 0
                            ? '---'
                            : widget.CarData.ToyID,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: OptimizedCacheImage(imageUrl: widget.CarData.img_url)),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: chaseCarText(widget.CarData.ChaseCar)),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: ExclusiveCarText(widget.CarData.Exclusive)),
              ],
            ),
          ),
        ));
  }

  Widget chaseCarText(List<String> chase) {
    var style;

    List<Widget> r = [Text('')];

    if (chase.length != 0) {
      for (var data in chase) {
        if (data.contains(
            RegExp('.*super treasure hunt.*', caseSensitive: false))) {
          style = TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.yellow[600]);
        } else if (data
            .contains(RegExp('.*treasure hunt.*', caseSensitive: false))) {
          style = TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[800]);
        } else {
          style = TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple[600]);
        }
        r.add(Text(
          data,
          style: style,
        ));
        r.add(Text(
          ', ',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ));
      }
      r.removeLast();
    }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: r);
  }


  Widget ExclusiveCarText(List<String> exclusive) {
    String txt = '';
    var style = TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900]);
    List<Widget> r = [Text('')];

    if (exclusive.length != 0) {
      for (var data in exclusive) {
        // r.add(Text(
        //   data,
        //   style: style,
        // ));
        // r.add(Text(
        //   ', ',
        //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        // ));
        txt+=data;
        txt+=', \n';
      }
      txt = txt.substring(0,txt.length-3);
      //r.removeLast();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(txt,style: style),
      ],
    );
  }
}
