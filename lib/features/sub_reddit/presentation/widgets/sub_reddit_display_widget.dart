import 'package:flutter/material.dart';
import 'package:flutter_technical_test/features/sub_reddit/domain/entities/sub_reddit.dart';

class SubRedditDisplay extends StatelessWidget {
  final SubReddit subReddit;
  final Size size;

  const SubRedditDisplay({Key key, this.subReddit, this.size})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width,
        height: size.height,
        child: ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: subReddit.children.length,
            itemBuilder: (BuildContext context, int i) {
              var data = subReddit.children[i].data;
              return Container(
                  child: Card(
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                        Padding(
                            child: Text(
                                "\u{1F44D} ${data.score}  ${data.author}",
                                textAlign: TextAlign.right,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6))),
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 16.0)),
                        Padding(
                            child: Text(
                              data.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                              textScaleFactor: 1.0,
                            ),
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 16.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ])),
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 16.0, bottom: 0.0));
            }));
  }
}
