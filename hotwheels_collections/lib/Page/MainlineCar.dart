import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hotwheels_collections/customWidget/countBar.dart';
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
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   title: Text(widget.CarData.ModelName),
        // ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            addDialog();
          },
          icon: Icon(Icons.check),
          label: Text('Add to collections'),
        ),
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
                      child: OptimizedCacheImage(
                          imageUrl: widget.CarData.img_url)),
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
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[900]);
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
        txt += data;
        txt += ', \n';
      }
      txt = txt.substring(0, txt.length - 3);
      //r.removeLast();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(txt, style: style),
      ],
    );
  }

  Future addDialog() => showDialog(
      context: context,
      builder: (context) {
        int num = 1;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add new model to the collection.'),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  widget.CarData.ModelName,
                  style: TextStyle(
                      color: Colors.orange[900], fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    children: [
                      Text('Note (optional)'),
                    ],
                  ),
                ),
                Card(
                    color: HexColor('#ECECEC'),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: controller,
                        maxLines: 5, //or null
                        decoration: InputDecoration.collapsed(
                            hintText: "Enter your text here"),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Count : "),
                      RawMaterialButton(
                        onPressed: () {
                          if (num < 99) {
                            setState(() {
                              num++;
                            });
                          }
                        },
                        elevation: 2.0,
                        fillColor: Colors.orange,
                        child: Icon(
                          Icons.add,
                          size: 30.0,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(5.0),
                        shape: CircleBorder(),
                      ),
                      Text(num.toString()),
                      RawMaterialButton(
                        onPressed: () {
                          if (num > 1) {
                            setState(() {
                              num--;
                            });
                          }
                        },
                        elevation: 2.0,
                        fillColor: Colors.orange,
                        child: Icon(
                          Icons.remove,
                          size: 30.0,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(5.0),
                        shape: CircleBorder(),
                      )
                    ],
                  ),
                ),
              ]),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: (() {
                    Navigator.pop(context);
                  }),
                ),
                TextButton(
                  child: Text('Add'),
                  onPressed: (() {
                    print("count : $num");
                  }),
                )
              ],
            );
          },
        );
      });

  void add() {}
}
